"use strict";

module.exports = {
    showAll: showAll,
    searchAll: searchAll,
    showSpecialFormogenhet: showSpecialFormogenhet
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

async function showAll() {
    let sql = `CALL show_all();`;
    let res = await db.query(sql);

    return res[0];
}

async function searchAll(data) {
    let sql = `CALL search_all(?);`;
    let res = await db.query(sql, [data]);

    return res[0];
}

async function showSpecialFormogenhet() {
    let sql = `CALL show_special2();`;
    let res = await db.query(sql);

    return res[0];
}
