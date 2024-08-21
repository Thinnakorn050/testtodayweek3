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




const con = require('./db');
const express = require('express');
const bcrypt = require('bcrypt');
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Password generator
app.get('/password/:pass', (req, res) => {
    const password = req.params.pass;
    bcrypt.hash(password, 10, function(err, hash) {
        if(err) {
            return res.status(500).send('Hashing error');
        }
        res.send(hash);
    });
});

// Login
app.post('/login', (req, res) => {
    const {username, password} = req.body;
    const sql = "SELECT id, password FROM users WHERE username = ?";
    con.query(sql, [username], function(err, results) {
        if(err) {
            return res.status(500).send("Database server error");
        }
        if(results.length != 1) {
            return res.status(401).send("Wrong username");
        }
        // Compare passwords
        bcrypt.compare(password, results[0].password, function(err, same) {
            if(err) {
                return res.status(500).send("Hashing error");
            }
            if(same) {
                return res.send("Login OK");
            }
            return res.status(401).send("Wrong password");
        });
    });
});

// Get all expenses
app.get('/expenses', (req, res) => {
    const sql = "SELECT * FROM expense";
    con.query(sql, (err, results) => {
        if(err) {
            return res.status(500).send("Database server error");
        }
        res.json(results);
    });
});

// Get today's expenses
app.get('/expenses/today', (req, res) => {
    const today = new Date().toISOString().split('T')[0]; // Get YYYY-MM-DD format
    const sql = "SELECT * FROM expense WHERE DATE(date) = ?";
    con.query(sql, [today], (err, results) => {
        if(err) {
            return res.status(500).send("Database server error");
        }
        res.json(results);
    });
});

// Search expenses by name
app.get('/expenses/search', (req, res) => {
    const keyword = `%${req.query.keyword}%`;
    const sql = "SELECT * FROM expense WHERE item LIKE ?";
    con.query(sql, [keyword], (err, results) => {
        if(err) {
            return res.status(500).send("Database server error");
        }
        res.json(results);
    });
});


// Add new expense
app.post('/expenses', (req, res) => {
    const { item, amount, date } = req.body;  
    console.log("Received:", item, amount, date); 
    const sql = "INSERT INTO expense (item, paid, date) VALUES (?, ?, ?)";
    con.query(sql, [item, amount, date], (err, results) => {
        if(err) {
            console.error("Database error:", err);  
            return res.status(500).send("Database server error");
        }
        console.log("Results:", results); 
        res.status(200).send("Expense added successfully");
    });
});




// Delete expense
app.delete('/expenses/:id', (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM expense WHERE id = ?";
    con.query(sql, [id], (err, results) => {
        if(err) {
            return res.status(500).send("Database server error");
        }
        if (results.affectedRows === 0) {
            return res.status(404).send("Expense not found");
        }
        res.status(200).send("Expense deleted successfully");
    });
});

// Server starts here
const PORT = 4000;
app.listen(PORT, () => {
    console.log('Server is running at ' + PORT);
});