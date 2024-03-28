/**
 * Routes for the eshop.
 */
"use strict";

const express = require("express");
const formogenhet   = require("../src/formogenhet.js"); //used for functions
const router  = express.Router();


router.get("/", (req, res) => {
    res.redirect("exam/index");  // Redirect to index
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | formogenhet"
    };

    res.render("formogenhet/pages/index", data);
}
);

router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | formogenhet"
    };

    data.res = await formogenhet.showAll();
    console.info(data.res);
    res.render("formogenhet/pages/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Search | formogenhet"
    };

    data.res = await formogenhet.showAll();
    console.info(data.res);
    res.render("formogenhet/pages/search", data);
});


router.post("/search", async (req, res) => {
    let data = {
        title: "Search | formogenhet"
    };

    data.res = await formogenhet.searchAll(req.body.namn);
    console.info(data.res);
    res.render("formogenhet/pages/search", data);
});

module.exports = router;
