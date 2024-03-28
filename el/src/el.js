"use strict";

module.exports = {
    showAllKraftverk: showAllKraftverk,
    showAllKonsumenter: showAllKonsumenter,
    searchAllKraftverk: searchAllKraftverk,
    searchAllKonsumenter: searchAllKonsumenter,
    showKraftverkWithoutURL: showKraftverkWithoutURL,
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

async function showAllKraftverk() {
    let sql = `CALL show_all_kraftverk();`;
    let res = await db.query(sql);

    return res[0];
}

async function showKraftverkWithoutURL() {
    let sql = `CALL show_kraftverk_without_url();`;
    let res = await db.query(sql);

    return res[0];
}


async function showAllKonsumenter() {
    let sql = `CALL show_all_konsument();`;
    let res = await db.query(sql);

    return res[0];
}





async function searchAllKraftverk(data) {
    let sql = `CALL search_all_kraftverk(?);`;
    let res = await db.query(sql, [`%${data.kraftverk}%`]);

    return res[0];
}

async function searchAllKonsumenter(data) {
    let sql = `CALL search_all_konsument(?);`;
    let res = await db.query(sql, [`%${data.konsumenter}%`]);

    return res[0];
}

async function showSpecial() {
    let sql = `CALL show_special();`;
    let res = await db.query(sql);

    return res[0];
}

// async function searchKraftverk(id, namn, plats, kalla){
//     let sql = `CALL search_kraftverk(?, ?, ?, ?, ?);`;
//     let res = await db.query(sql, [id, namn, typ, kapacitet, pris]);

//     return res[0];
// }

// async function searchKonsument(id, )
