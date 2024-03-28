/**
 * Routes for the eshop.
 */
"use strict";

const express = require("express");
const exam   = require("../src/exam.js"); //used for functions
const router  = express.Router();


router.get("/", (req, res) => {
    res.redirect("exam/index");  // Redirect to index
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | AI"
    };

    res.render("exam/pages/index", data);
}
);

router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | AI"
    };

    data.res = await exam.showAllProduct();
    console.info(data.res);
    res.render("exam/pages/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Search | AI"
    };

    data.res = await exam.showAllProduct();
    console.info(data.res);
    res.render("exam/pages/search", data);
});


router.post("/search", async (req, res) => {
    let data = {
        title: "Search | AI"
    };

    data.res = await exam.searchAllProduct(req.body);

    console.info(data.res);
    res.render("exam/pages/search", data);
});

module.exports = router;
