require("dotenv").config();

const express = require("express");
const app = express();
const port = 8080;
const mysql = require("mysql2");
const cors = require("cors");
const bodyParser = require("body-parser");

let corsOptions = {
  origin: "*",
  credential: true,
};
app.use(cors(corsOptions));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const connection = mysql.createConnection(process.env.DATABASE_URL);

// const url = require("url");

// const databaseUrl = process.env.DATABASE_URL;
// const parsedUrl = new URL(databaseUrl);

// console.log("Host:", parsedUrl.host);
// console.log("Username:", parsedUrl.username);
// console.log("Password:", parsedUrl.password);
// console.log("Port:", parsedUrl.port);
// console.log("Pathname:", parsedUrl.pathname);

// const connection = mysql.createConnection({
//   host: "aws.connect.psdb.cloud",
//   user: process.env.DATABASE_USER,
//   password: process.env.DATABASE_PASSWORD,
//   database: "possystem",
//   ssl: JSON.parse(process.env.DATABASE_SSL || "{}"),
// });

// let connection = mysql.createConnection({
//   host: "127.0.0.1",
//   user: "root",
//   password: "Sonny0401@",
//   database: "posSystem",
// });

connection.connect(function (err) {
  if (err) {
    return console.error("error: " + err.message);
  }

  console.log("Connected to the MySQL server.");
});

app.get("/", (req, res) => {
  res.send("posMachine!");
});

app.get("/categories", (req, res) => {
  connection.query("select * from categories", (err, result) => {
    console.log("categories");
    res.send(result);
  });
});

app.get("/foods", (req, res) => {
  connection.query("select * from foods", (err, result) => {
    console.log("foods");
    res.send(result);
  });
});

app.post("/order", (req, res) => {
  const inputDateTime = new Date(req.body.orderTime);
  const formattedDateTime = inputDateTime.toISOString().slice(0, 19).replace("T", " ");

  const insertOrder =
    "INSERT INTO `order` (orderTime, totalPrice, payment, totalQty) VALUES (?, ?, ?, ?)";
  const OrderValues = [formattedDateTime, req.body.totalPrice, req.body.payment, req.body.totalQty];

  //regarding transaction error
  connection.beginTransaction((err) => {
    if (err) {
      console.error("Error while beginning transaction:", err);
      return res.status(500).json({
        code: 500,
        message: "Error while processing the request",
      });
    }

    //Insert order table
    connection.query(insertOrder, OrderValues, (err, orderResult) => {
      if (err) {
        console.error("Error while inserting order data:", err);
        //reverse when error
        connection.rollback(() => {
          console.error("Transaction rolled back.");
          return res.status(500).json({
            code: 500,
            message: "Error while processing the request",
          });
        });
      } else {
        const orderNumber = orderResult.insertId;

        //received a object data from client
        const orderItemsRequests = req.body.items.map((cartItem) => ({
          orderNumber: orderNumber,
          item: cartItem.name,
          qty: cartItem.cartQuantity,
        }));

        const insertOrderItems = "INSERT INTO `orderItems` (orderNumber, item, qty) VALUES ?";

        const orderItemsValues = orderItemsRequests.map((orderItem) => [
          orderItem.orderNumber,
          orderItem.item,
          orderItem.qty,
        ]);
        //INSERT to ORDERITEMS table
        connection.query(insertOrderItems, [orderItemsValues], (err, itemResult) => {
          if (err) {
            //if fail reverse it
            console.error("Error while inserting order items data:", err);
            connection.rollback(() => {
              console.error("Transaction rolled back.");
              return res.status(500).json({
                code: 500,
                message: "Error while processing the request",
              });
            });
          } else {
            connection.commit((commitError) => {
              if (commitError) {
                console.error("Error while committing transaction:", commitError);
                connection.rollback(() => {
                  console.error("Transaction rolled back.");
                  return res.status(500).json({
                    code: 500,
                    message: "Error while processing the request",
                  });
                });
              } else {
                console.log(itemResult, "itemResult");
                return res.status(200).json({
                  code: 200,
                });
              }
            });
          }
        });
      }
    });
  });
});

app.get("/adminCategories", (req, res) => {
  connection.query("select * from adminCategories", (err, result) => {
    console.log("adminCategories");
    res.send(result);
  });
});

app.get("/adminOrder", (req, res) => {
  const page = req.query.page || 1;
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const selectedStatus = req.query.status || "Pending";
  const whereClause =
    selectedStatus === "Pending"
      ? "WHERE status = 'Pending' OR status IS NULL"
      : "WHERE status = 'Completed'";

  // 먼저 전체 아이템에서 펜딩인지 컴플리트인지 거르기
  connection.query(
    `SELECT COUNT(*) as totalCount FROM \`order\` ${whereClause}`,
    (err, countResult) => {
      if (err) {
        console.error(err);
        res.status(500).send("Internal Server Error");
        return;
      }

      const totalCount = countResult[0].totalCount;
      const totalPages = Math.ceil(totalCount / itemsPerPage);

      // 현재 페이지에 해당하는 아이템만을 반환합니다.
      connection.query(
        `SELECT * FROM \`order\` ${whereClause} ORDER BY \`orderTime\` DESC LIMIT ${itemsPerPage} OFFSET ${offset}`,
        (err, result) => {
          if (err) {
            console.error(err);
            res.status(500).send("Internal Server Error");
            return;
          }

          res.send({ data: { result, totalPages } });
        }
      );
    }
  );
});

app.post("/updateStatus/:updateId", (req, res) => {
  const orderId = req.params.updateId;
  const newStatus = req.body.status;

  const updateStatusQuery = "UPDATE `order` SET status = ? WHERE id = ?";
  const updateStatusValues = [newStatus, orderId];

  connection.query(updateStatusQuery, updateStatusValues, (err, result) => {
    if (err) {
      console.error("Error while updating status:", err);
      return res.status(500).json({
        code: 500,
        message: "Error while processing the request",
      });
    } else {
      console.log(result, "statusResult");
      return res.status(200).json({
        code: 200,
      });
    }
  });
});

app.get("/adminOrderDetail/:id", (req, res) => {
  const orderId = req.params.id;

  connection.query("SELECT * FROM orderItems WHERE orderNumber = ?", [orderId], (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send("Internal Server Error");
      return;
    }

    console.log("adminOrderDetail");
    res.send(result);
  });
});
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
