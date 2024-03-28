/**
 * Routes for the eshop.
 */
"use strict";

const express = require("express");
const el   = require("../src/el.js"); //used for functions
const router  = express.Router();


router.get("/", (req, res) => {
    res.redirect("exam/index");  // Redirect to index
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | el"
    };

    res.render("el/pages/index", data);
}
);

router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | el"
    };

    data.res = await el.showAllKraftverk();
    data.res2 = await el.showAllKonsumenter();
    console.info(data.res);
    console.info(data.res2);
    res.render("el/pages/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Search | el"
    };

    data.res = await el.showAllKraftverk();
    data.res2 = await el.showAllKonsumenter();
    console.info(data.res);
    console.info(data.res2);
    res.render("el/pages/search", data);
});


router.post("/search", async (req, res) => {
    let data = {
        title: "Search | el"
    };

    data.res = await el.searchAllKraftverk(req.body);
    data.res2 = await el.searchAllKonsumenter(req.body);

    console.info(data.res);
    console.info(data.res2);
    res.render("el/pages/search", data);
});

module.exports = router;
