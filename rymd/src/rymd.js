"use strict";

module.exports = {
    showRymd: showRymd,
    searchRymd: searchRymd,
    showRymdWithoutUrl: showRymdWithoutUrl,
    showSpecialRymd: showSpecialRymd
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

async function showRymd() {
    let sql = `CALL show_rymd();`;
    let res;

    res = await db.query(sql);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}

async function searchRymd(data) {
    let sql = `CALL search_rymd(?);`;
    let res;

    res = await db.query(sql, [`%${data.namn}%`]);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}
async function showRymdWithoutUrl() {
    let sql = `CALL show_rymd_without_url();`;
    let res;

    res = await db.query(sql);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}
async function showSpecialRymd() {
    let sql = `CALL show_rymd_with_days();`;
    let res;

    res = await db.query(sql);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
    return res[0];
}
