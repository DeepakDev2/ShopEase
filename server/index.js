const express = require("express");
const dotenv = require("dotenv");
const authRouter = require("./routes/auth");
const { connectToDB } = require("./connections");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

dotenv.config(); // <-- Load environment variables

const app = express();
const PORT = process.env.PORT || 8000;
app.use(express.json());

const DB = process.env.DB_URL;
connectToDB(DB)
	.then(() => console.log("Connected to DB"))
	.catch((err) => console.log("Error", err));

app.use("/", authRouter);
app.use("/", adminRouter);
app.use("/", productRouter);
app.use("/", userRouter);

app.listen(PORT, "0.0.0.0", () => {
	console.log("Server started at Port:", PORT);
});
