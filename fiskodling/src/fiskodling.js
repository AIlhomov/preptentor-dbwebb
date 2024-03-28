"use strict";

module.exports = {
    showAllFish: showAllFish,
    showSpecial: showSpecial,
    showAllFishWithoutUrl: showAllFishWithoutUrl,
    searchAllFish: searchAllFish

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

async function showAllFish() {
    let sql = `CALL fisk_rapport();`;
    let res = await db.query(sql);

    return res[0];
}

async function showAllFishWithoutUrl() {
    let sql = `CALL fisk_rapport_without_url();`;
    let res = await db.query(sql);

    return res[0];
}

async function searchAllFish(data) {
    let sql = `CALL fisk_rapport_search(?);`;
    let res = await db.query(sql, [`%${data.fisk}%`]);

    return res[0];
}

async function showSpecial() {
    let sql = `CALL show_special();`;
    let res = await db.query(sql);

    return res[0];
}
