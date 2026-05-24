const express = require('express');
const { Pool } = require('pg');

const app = express();

app.use(express.json());

app.use(express.static('public'));

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD
});

(async () => {

    await pool.query(`
        CREATE TABLE IF NOT EXISTS messages (
            id SERIAL PRIMARY KEY,
            username TEXT NOT NULL,
            message TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    `);

})();

app.get('/messages', async (req, res) => {

    const result = await pool.query(`
        SELECT *
        FROM messages
        ORDER BY id DESC
        LIMIT 50
    `);

    res.json(result.rows.reverse());
});

app.post('/messages', async (req, res) => {

    await pool.query(
        `
        INSERT INTO messages(username, message)
        VALUES($1, $2)
        `,
        [
            req.body.username,
            req.body.message
        ]
    );

    res.json({ success: true });
});

app.get('/health', (req, res) => {

    res.status(200).json({
        status: 'UP'
    });
});

app.listen(3000, () => {

    console.log('Server running on port 3000');
});
