/**
 * Routes for the eshop.
 */
"use strict";

const express = require("express");
const rymd   = require("../src/rymd.js"); //used for functions
const router  = express.Router();


router.get("/", (req, res) => {
    res.redirect("exam/index");  // Redirect to index
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | rymd"
    };

    res.render("rymd/pages/index", data);
}
);

router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | rymd"
    };

    data.res = await rymd.showRymd();
    console.info(data.res);
    res.render("rymd/pages/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Search | rymd"
    };

    data.res = await rymd.showRymd();
    console.info(data.res);


    res.render("rymd/pages/search", data);
});

router.post("/search", async (req, res) => {
    console.info("search: ", req.body);
    let data = {};

    data.res = await rymd.searchRymd(req.body);
    res.render("rymd/pages/search", data);
    console.log(data.res);
});

module.exports = router;
