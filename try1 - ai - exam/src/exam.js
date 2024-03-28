"use strict";

module.exports = {
    showAllProduct: showAllProduct,
    showAllProductWithoutUrl: showAllProductWithoutUrl,
    searchAllProduct: searchAllProduct,
    showSpecial: showSpecial

};

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

(async function() {
    db = await mysql.createConnection(config);
    process.on("exit", () => {
        db.end();
    });
})();

async function showAllProduct() {
    let sql = `CALL show_all_products();`;
    let res = await db.query(sql);

    return res[0];
}

async function showAllProductWithoutUrl() {
    let sql = `CALL show_all_products_without_url();`;
    let res = await db.query(sql);

    return res[0];
}

async function searchAllProduct(data) {
    let sql = `CALL search_all_products(?);`;
    let res = await db.query(sql, [`%${data.exam}%`]);

    return res[0];
}

async function showSpecial() {
    let sql = `CALL show_special();`;
    let res = await db.query(sql);

    return res[0];
}
