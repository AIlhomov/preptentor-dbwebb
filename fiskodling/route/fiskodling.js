/**
 * Routes for the eshop.
 */
"use strict";

const express = require("express");
const fisk   = require("../src/fiskodling.js"); //used for functions
const router  = express.Router();


router.get("/", (req, res) => {
    res.redirect("exam/index");  // Redirect to index
}
);

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | fisk"
    };

    res.render("fiskodling/pages/index", data);
}
);

router.get("/visa", async (req, res) => {
    let data = {
        title: "Visa | fisk"
    };

    data.res = await fisk.showAllFish();
    console.info(data.res);
    res.render("fiskodling/pages/visa", data);
});

router.get("/search", async (req, res) => {
    let data = {
        title: "Search | fisk"
    };

    data.res = await fisk.showAllFish();
    console.info(data.res);
    res.render("fiskodling/pages/search", data);
});


router.post("/search", async (req, res) => {
    let data = {
        title: "Search | fisk"
    };

    data.res = await fisk.searchAllFish(req.body);

    console.info(data.res);
    res.render("fiskodling/pages/search", data);
});

module.exports = router;
