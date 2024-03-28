"use strict";

const readline = require('readline-promise').default;
const exam = require('./src/exam.js');

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function exitProgram(exitcode=0) {
    console.log("Exiting program");
    process.exit(exitcode);
}

function showMenu() {
    console.log(`
        Choose something from the menu:
        exit, quit - Exit the program
        menu, help - Show this menu

        visa - Show all Products
        search <str> - shows what you searched for
        report - shows the table the boss asked for
    `);
}


async function main() {
    rl.setPrompt('Exam: ');
    rl.prompt();

    rl.on("close", exitProgram);

    let res, res1, res2;

    rl.on('line', async function (input) {
        input = input.trim().toLowerCase();
        let parts = input.split(" ");

        switch (parts[0]) {
            case "quit":
            case "exit":
                exitProgram();
                break;
            case "menu":
            case "help":
                showMenu();
                break;
            case "visa":
                res = await exam.showAllProductWithoutUrl();
                console.table(res);
                break;
            case "search":
                res1 = await exam.searchAllProduct({exam: parts[1]});
                console.table(res1);
                break;
            case "report":
                res2 = await exam.showSpecial();
                console.table(res2);
                break;
            default:
                console.log("I dont know this command, type 'menu' to seek help.");
                break;
        }
        rl.prompt();
    });
}

main();
