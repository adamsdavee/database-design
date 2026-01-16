use inventoryDB

// CREATION OF ENTITIES

db.createCollection("users")
db.createCollection("items")
db.createCollection("orders")


// INSERT INTO ENTITIES


// USERS
db.users.insertMany([
  {
    _id: ObjectId("65aaa1111111111111111111"),
    name: "Admin User",
    email: "admin@company.com",
    role: "admin"
  },
  {
    _id: ObjectId("65aaa2222222222222222222"),
    name: "John Doe",
    email: "john@company.com",
    role: "user"
  }
])

// ITEMS
db.items.insertMany([
  {
    _id: ObjectId("65bbb1111111111111111111"),
    name: "Laptop",
    price: 1500,
    size: "medium",
    category: "electronics",
    quantity: 10
  },
  {
    _id: ObjectId("65bbb2222222222222222222"),
    name: "Printer Paper",
    price: 20,
    size: "small",
    category: "office_supplies",
    quantity: 100
  }
])

// ORDERS
db.orders.insertOne({
  user_id: ObjectId("65aaa2222222222222222222"),
  status: "pending",
  items: [
    {
      item_id: ObjectId("65bbb1111111111111111111"),
      quantity: 1,
      unit_price: 1500
    },
    {
      item_id: ObjectId("65bbb2222222222222222222"),
      quantity: 2,
      unit_price: 20
    }
  ]
})


// GET RECORDS FROM TWO COLLECTIONS/ENITIES
db.orders.find(
  { status: "pending" },
  { user_id: 1, status: 1 }
)


// UPDATE RECORDS FROM TWO COLLECTIONS/ENITIES

db.orders.updateOne(
  { status: "pending" },
  {
    $set: {
      status: "approved",
      approved_by: ObjectId("65aaa1111111111111111111")
    }
  }
)


// DELETE RECORDS FROM TWO COLLECTIONS/ENITIES
db.orders.deleteOne({ status: "rejected" })


// QUERY RECORDS FROM COLLECTIONS/ENITIES USING LOOKUP


db.orders.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "user_id",
      foreignField: "_id",
      as: "user_details"
    }
  },
  {
    $lookup: {
      from: "items",
      localField: "items.item_id",
      foreignField: "_id",
      as: "item_details"
    }
  }
])
