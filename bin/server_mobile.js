// //---------------Test today------------------//
// const con = require('./db');
// const express = require('express');
// const bcrypt = require('bcrypt');
// const app = express();


// app.use(express.json());
// app.use(express.urlencoded({ extended: true }));


// // password generator
// app.get('/password/:pass', (req, res) => {
//     const password = req.params.pass;
//     bcrypt.hash(password, 10, function(err, hash) {
//         if(err) {
//             return res.status(500).send('Hashing error');
//         }
//         res.send(hash);
//     });
// });


// // login
// app.post('/login', (req, res) => {
//     const {username, password} = req.body;
//     const sql = "SELECT id, password FROM users WHERE username = ?";
//     con.query(sql, [username], function(err, results) {
//         if(err) {
//             return res.status(500).send("Database server error");
//         }
//         if(results.length != 1) {
//             return res.status(401).send("Wrong username");
//         }
//         // compare passwords
//         bcrypt.compare(password, results[0].password, function(err, same) {
//             if(err) {
//                 return res.status(500).send("Hashing error");
//             }
//             if(same) {
//                 return res.send("Login OK");
//             }
//             return res.status(401).send("Wrong password");
//         });
//     })
// });


// // ---------- Server starts here ---------
// const PORT = 3000;
// app.listen(PORT, () => {
//     console.log('Server is running at ' + PORT);
// });


// //---------------Test today------------------//
const express = require('express');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');

const app = express();
app.use(express.json());
// การเชื่อมต่อกับ MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'expenses_db'
});

// API สำหรับการเข้าสู่ระบบ
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
            const user = results[0];
            const hashedPassword = crypto.createHash('sha256').update(password).digest('hex');  // ใช้ SHA256
            if (hashedPassword === user.password) {
                res.json({ message: 'เข้าสู่ระบบสำเร็จ', userId: user.id });
            } else {
                res.status(401).json({ message: 'ข้อมูลเข้าสู่ระบบไม่ถูกต้อง' });
            }
        } else {
            res.status(404).json({ message: 'ไม่พบผู้ใช้งาน' });
        }
    });
});

// API สำหรับดึงข้อมูลการใช้จ่ายทั้งหมด
app.get('/expenses', (req, res) => {
    const userId = req.query.userId;
    db.query('SELECT * FROM expenses WHERE user_id = ?', [userId], (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// API สำหรับเพิ่มรายการใช้จ่ายใหม่
app.post('/expenses', (req, res) => {
    const { userId, item, paid, date } = req.body;
    db.query('INSERT INTO expenses (user_id, item, paid, date) VALUES (?, ?, ?, ?)',
        [userId, item, paid, date],
        (err, results) => {
            if (err) throw err;
            res.json({ message: 'เพิ่มรายการใช้จ่ายสำเร็จ', expenseId: results.insertId });
        });
});

// API สำหรับลบรายการใช้จ่าย
app.delete('/expenses/:id', (req, res) => {
    const expenseId = req.params.id;
    db.query('DELETE FROM expenses WHERE id = ?', [expenseId], (err, results) => {
        if (err) throw err;
        res.json({ message: 'ลบรายการสำเร็จ' });
    });
});

app.listen(4000, () => {
    console.log('เซิร์ฟเวอร์ทำงานที่พอร์ต 4000');
});
