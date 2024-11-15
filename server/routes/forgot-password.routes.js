const router = require("express").Router();
const pool = require("../db/sdg.db.js");
const bcrypt = require("bcrypt");
const crypto = require("crypto");

// Helper function to generate a 6-digit OTP
// Generate a 6-digit OTP

// Send OTP route
router.post("/send-otp", async (req, res) => {
    const { email } = req.body;

    try {
        // Fetch the user ID based on the provided email
        const userResult = await pool.query(
            "SELECT user_id FROM sd_office WHERE email = $1",
            [email]
        );

        if (userResult.rowCount === 0) {
            return res
                .status(404)
                .json({ success: false, message: "User not found." });
        }

        const userId = userResult.rows[0].user_id;

        // Generate OTP and expiration time (5 minutes from now)

        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const expiration = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes from now
        console.log(otp);

        // Hash the OTP before saving to the database
        const hashedOtp = await bcrypt.hash(otp, 10);

        // Insert or update OTP in the user_otp table
        await pool.query(
            `INSERT INTO user_otp (user_id, otp, expiration)
             VALUES ($1, $2, $3)
             ON CONFLICT (user_id)
             DO UPDATE SET otp = $2, expiration = $3`,
            [userId, hashedOtp, expiration]
        );

        // Send OTP (in a real application, send via email or SMS)
        console.log(`OTP for ${email}: ${otp}`); // Log OTP for development purposes only

        return res.status(200).json({
            success: true,
            message: "OTP sent successfully.",
            otp: otp,
        });
    } catch (error) {
        console.error("Error sending OTP:", error);
        return res
            .status(500)
            .json({ success: false, message: "Failed to send OTP." });
    }
});

// Send OTP route
// router.post("/send-otp", async (req, res) => {
//     const { email } = req.body;

//     try {
//         // Fetch the user ID based on the provided email
//         const userResult = await pool.query(
//             "SELECT user_id FROM sd_office WHERE email = $1",
//             [email]
//         );

//         if (userResult.rowCount === 0) {
//             return res
//                 .status(404)
//                 .json({ success: false, message: "User not found." });
//         }

//         const userId = userResult.rows[0].user_id;

//         // Check if there's an existing OTP for the user and if it is expired or not
//         const otpResult = await pool.query(
//             "SELECT otp, expiration FROM user_otp WHERE user_id = $1",
//             [userId]
//         );

//         if (otpResult.rowCount > 0) {
//             const { otp: storedHashedOtp, expiration } = otpResult.rows[0];

//             // Check if OTP has expired
//             if (new Date() < new Date(expiration)) {
//                 // OTP exists and has not expired, reuse the existing OTP
//                 return res
//                     .status(200)
//                     .json({
//                         success: true,
//                         message: "OTP already sent. Please check your email.",
//                     });
//             }
//         }

//         // Generate new OTP if none exists or if the existing OTP has expired
//         const otp = Math.floor(100000 + Math.random() * 900000).toString();
//         const expiration = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes from now
//         console.log(otp);

//         // Hash the OTP before saving to the database
//         const hashedOtp = await bcrypt.hash(otp, 10);

//         // Insert or update OTP in the user_otp table
//         await pool.query(
//             `INSERT INTO user_otp (user_id, otp, expiration)
//              VALUES ($1, $2, $3)
//              ON CONFLICT (user_id)
//              DO UPDATE SET otp = $2, expiration = $3`,
//             [userId, hashedOtp, expiration]
//         );

//         // Send OTP (in a real application, send via email or SMS)
//         console.log(`OTP for ${email}: ${otp}`); // Log OTP for development purposes only

//         return res
//             .status(200)
//             .json({ success: true, message: "OTP sent successfully." });
//     } catch (error) {
//         console.error("Error sending OTP:", error);
//         return res
//             .status(500)
//             .json({ success: false, message: "Failed to send OTP." });
//     }
// });

// Verify OTP route
router.post("/verify-otp", async (req, res) => {
    const { email, otp } = req.body;

    try {
        // Fetch the user ID based on the provided email
        const userResult = await pool.query(
            "SELECT user_id FROM sd_office WHERE email = $1",
            [email]
        );

        if (userResult.rowCount === 0) {
            return res
                .status(404)
                .json({ success: false, message: "User not found." });
        }

        const userId = userResult.rows[0].user_id;

        // Retrieve the stored OTP and expiration time for the user
        const otpResult = await pool.query(
            "SELECT otp, expiration FROM user_otp WHERE user_id = $1",
            [userId]
        );

        if (otpResult.rowCount === 0) {
            return res
                .status(404)
                .json({ success: false, message: "OTP not found." });
        }

        const { otp: storedHashedOtp, expiration } = otpResult.rows[0];

        // Check if OTP has expired
        if (new Date() > new Date(expiration)) {
            return res
                .status(400)
                .json({ success: false, message: "OTP has expired." });
        }

        // Compare the provided OTP with the stored hashed OTP
        const isMatch = await bcrypt.compare(otp, storedHashedOtp);

        if (isMatch) {
            return res
                .status(200)
                .json({ success: true, message: "OTP verified successfully." });
        } else {
            return res
                .status(400)
                .json({ success: false, message: "Invalid OTP." });
        }
    } catch (error) {
        console.error("Error verifying OTP:", error);
        return res
            .status(500)
            .json({ success: false, message: "Failed to verify OTP." });
    }
});

// Route to reset password based on email
// router.patch("/reset-password", async (req, res) => {
//     const { email, password } = req.body;

//     // Check if email and password are provided
//     if (!email || !password) {
//         return res.status(400).json({
//             success: false,
//             message: "Email and password are required.",
//         });
//     }

//     // Validate password strength (basic check for this example)
//     const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/;
//     if (!passwordRegex.test(password)) {
//         return res.status(400).json({
//             success: false,
//             message:
//                 "Password must be at least 8 characters long and contain both letters and numbers.",
//         });
//     }

//     try {
//         // Hash the new password
//         const hashedPassword = await bcrypt.hash(password, 10);

//         // Update the password in the database for the user with the given email
//         const result = await pool.query(
//             "UPDATE public.sd_office SET password = $1 WHERE email = $2 RETURNING user_id",
//             [hashedPassword, email]
//         );

//         if (result.rows.length === 0) {
//             return res.status(404).json({
//                 success: false,
//                 message: "User not found with the provided email.",
//             });
//         }

//         // Return a success response if the password is updated
//         res.json({
//             success: true,
//             message: "Password has been successfully reset.",
//         });
//     } catch (error) {
//         console.error("Error resetting password:", error);
//         res.status(500).json({
//             success: false,
//             message: "An error occurred while resetting the password.",
//         });
//     }
// });

router.patch("/reset-password", async (req, res) => {
    const { email, password } = req.body;

    // Check if email and password are provided
    if (!email || !password) {
        return res.status(400).json({
            success: false,
            message: "Email and password are required.",
        });
    }

    // Validate password strength (basic check for this example)
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$/;
    if (!passwordRegex.test(password)) {
        return res.status(400).json({
            success: false,
            message:
                "Password must be at least 8 characters long and contain both letters and numbers.",
        });
    }

    try {
        // Hash the new password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Update the password in the database for the user with the given email
        const result = await pool.query(
            "UPDATE public.sd_office SET password = $1 WHERE email = $2 RETURNING user_id",
            [hashedPassword, email]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "User not found with the provided email.",
            });
        }

        // After the password is reset, delete the OTP for the user
        await pool.query(
            "DELETE FROM public.user_otp WHERE user_id = (SELECT user_id FROM public.sd_office WHERE email = $1)",
            [email]
        );

        // Return a success response if the password is updated
        res.json({
            success: true,
            message: "Password has been successfully reset, and OTP has been deleted.",
        });
    } catch (error) {
        console.error("Error resetting password:", error);
        res.status(500).json({
            success: false,
            message: "An error occurred while resetting the password.",
        });
    }
});


module.exports = router;
