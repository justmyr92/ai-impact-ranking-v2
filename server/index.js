const express = require("express");
const app = express();
const cors = require("cors");
const campusRoutes = require("./routes/campus.routes");
const sdOfficeRoutes = require("./routes/sd-office.routes");
const csdOfficeRoutes = require("./routes/csd-office.routes");
const instrumentsRoutes = require("./routes/instruments.routes");
const formulaRoutes = require("./routes/formula.routes");
const recordsRoutes = require("./routes/records.routes");
const forgotPasswordRoutes = require("./routes/forgot-password.routes");
const notificationRoutes = require("./routes/notification.routes");
const csdnotificationRoutes = require("./routes/notification.routes");

require("dotenv").config();

app.use(cors());

app.use(express.json());

app.use("/api", campusRoutes);
app.use("/api", sdOfficeRoutes);
app.use("/api", csdOfficeRoutes);
app.use("/api", instrumentsRoutes);
app.use("/api", formulaRoutes);
app.use("/api", recordsRoutes);
app.use("/api", forgotPasswordRoutes);
app.use("/api", notificationRoutes);
app.use("/api", csdnotificationRoutes);

app.listen(process.env.PORT, () => {
    console.log(`Server running on port ${process.env.PORT}`);
});
