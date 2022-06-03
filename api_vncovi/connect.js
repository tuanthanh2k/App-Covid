const sql = require('mssql/msnodesqlv8')

//Các thông tin kết nối CSDL
const config ={
    server: "DESKTOP-KMNS09Q",
    user: 'sa',
    password: '123456',
    database: 'DACN1_VNCOVI',
    driver: 'msnodesqlv8',
    options: {
        trustedConnection: true
      }
}

const connect = new sql.ConnectionPool(config).connect().then(pool => {
    return pool;
})

module.exports = {
    connect: connect,
    sql: sql,
}