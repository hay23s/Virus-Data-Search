<html>

    <head>
        <title>Virus Wiki</title>
    </head>

    <body>
        <h1>Virus Wiki</h1>

        <form class="inline">
            <style>
                .button {
                border: none;
                color: white;
                width: 200px;
                padding: 15px 32px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                background-color: #008CBA;
                }

                body {
                    max-width: max-content;
                    margin: auto;
                }
            </style>

            <button type="button" onclick="location='aggregations.php'" class="button button1">Virus Data</button>
            <br>
            <button type="button" onclick="location='join-div.php'" class="button button1">Merge Data</button>
            <br>
            <button type="button" onclick="location='select-project.php'" class="button button1">Filter Data</button>
            <br>
            <button type="button" onclick="location='insert,delete,update.php'" class="button button1">Add, Update, or Delete</button>
        </form>
    </body>

</html>