const express = require("express");
const app = express();
const port = 8080;
const mysql = require("mysql");
const cors = require("cors");
const bodyParser = require("body-parser");

let corsOptions = {
  origin: "*",
  credential: true,
};
app.use(cors(corsOptions));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

let connection = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "Sonny0401@",
  database: "posSystem",
});

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

  const insertOrder = "INSERT INTO `order` (orderTime, totalPrice, payment) VALUES (?, ?, ?)";
  const OrderValues = [formattedDateTime, req.body.totalPrice, req.body.payment];

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
        //insert to orderItems table
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
  console.log(res);
  connection.query("select * from order", (err, result) => {
    console.log(result, "result");
    console.log("adminOrder");
    res.send(result);
  });
});

app.get("/adminOrderDetail", (req, res) => {
  connection.query("select * from orderItems", (err, result) => {
    console.log("adminOrderDetail");
    res.send(result);
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
