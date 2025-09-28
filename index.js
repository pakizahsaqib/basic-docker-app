import express from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('Hello from the Dockerized Node.js App!');
});

//No DB connection for now

// const pool = new Pool({
//   user: 'app_user',
//   host: 'db',
//   database: 'app_db',
//   password: 'app_password',
//   port: 5432,
// });

// app.get('/', async (req, res) => {
//   try {
//     const result = await pool.query('SELECT NOW()');
//     res.json({
//       message: "Hello World",
//       time: result.rows[0].now
//     });
//   } catch (error) {
//     console.error('Error executing query', error);
//     res.status(500).json({ error: "Error connecting to the database" });
//   }
// });

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});