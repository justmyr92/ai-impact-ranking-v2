const express = require("express");
const pool = require("../db/sdg.db.js"); // Database connection
const router = express.Router();

// Insert Notification Route
router.post("/csd/create-notification", async (req, res) => {
    const { userId, notificationMessage } = req.body;

    // Validate input
    if (!userId || !notificationMessage) {
        return res
            .status(400)
            .json({ error: "User ID and notification message are required" });
    }

    try {
        // Insert notification into csd_notification table
        const result = await pool.query(
            "INSERT INTO csd_notification (notification_message, user_id) VALUES ($1, $2) RETURNING notif_id",
            [notificationMessage, userId]
        );

        const newNotifId = result.rows[0].notif_id;
        return res.status(201).json({ success: true, notif_id: newNotifId });
    } catch (err) {
        console.error("Error inserting notification: ", err);
        return res.status(500).json({ error: "Internal server error" });
    }
});

// Get Notifications Route
router.get("/csd/get-notifications", async (req, res) => {
    try {
        // Get all notifications from the csd_notification table
        const result = await pool.query(
            "SELECT notif_id, notification_message, date_received FROM csd_notification ORDER BY date_received DESC"
        );

        const notifications = result.rows;
        return res.status(200).json({ notifications });
    } catch (err) {
        console.error("Error fetching notifications: ", err);
        return res.status(500).json({ error: "Internal server error" });
    }
});

// Get Notifications by User ID Route
router.get("/csd/get-notifications-by-user_id", async (req, res) => {
    const { userId } = req.query;

    // Validate input
    if (!userId) {
        return res.status(400).json({ error: "User ID is required" });
    }

    try {
        // Get all notifications for a specific user from the csd_notification table
        const result = await pool.query(
            "SELECT notif_id, notification_message, date_received FROM csd_notification WHERE user_id = $1 ORDER BY date_received DESC",
            [userId]
        );

        const notifications = result.rows;
        return res.status(200).json({ notifications });
    } catch (err) {
        console.error("Error fetching notifications: ", err);
        return res.status(500).json({ error: "Internal server error" });
    }
});

module.exports = router;
