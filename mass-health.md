For this challenge we'll be working with a dataset provided by Massachusetts Health. We will import this data into a Postgres database and glean some insight from the data using SQL queries.

#### Setup

From your working directory, use the following command to create a new database:

```no-highlight
$ createdb mass_health
```

#### Create the database schema

You will need to write the necessary SQL statements to build the database schema to store the data in `mass-chip-data.csv`. Write these SQL statements in the `schema.sql` file. Name your table `town_health_records`. You can then execute these SQL statements on your database with the following command.

```no-highlight
$ psql mass_health < schema.sql
```

#### Import the data

The next step is to write some Ruby code to import the data in the `mass-chip-data.csv` file into the database. Use the Ruby CSV library, along with the PG gem to move the data from csv to the database. Store this code in the `import.rb` file.

#### Study the data

After the seed script has run the `mass_health_development` database should contain town health records. Verify this by connecting to the database with `psql` and querying the table:

```no-highlight
$ psql mass_health

mass_health_development=# SELECT * FROM town_health_records LIMIT 5;
```

This query should return a few rows from the `town_health_records` table. If no data is returned, there was a problem with importing.

Once the data has been verified use it to answer the following questions:

* What 3 towns have the highest population of citizens that are 65 years and older?
* What 3 towns have the highest population of citizens that are 19 years and younger?
* What 5 towns have the lowest per capita income?
* Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
* Omitting Boston, what town has the highest number of infant mortalities?

For each of the questions above, write the SQL query that can answer the question and save them in `questions.sql`. Place a comment before each query that contains the question it is answering (comments in SQL start with `--`). For example, the first query should look like:

```SQL
-- What 3 towns have the highest population of citizens that are 65 years and older?
SELECT ...
```

### User Stories

```no-highlight
As a database administrator
I want to seed the database from a CSV file
So that the analysts have some data to work with
```
Acceptance Criteria:
* Running the `ruby import.rb` command will populate the database with records.
* Running the `ruby import.rb` command multiple times will not create duplicate records.
* Each town in the data file should have a single `town_health_record` after running the command.

```no-highlight
As an analyst
I want to query the database
So that I can answer questions about the towns in Massachusetts
```
Acceptance Criteria:
* Must include queries to answer all of the questions listed above.
* SQL queries are stored in the `questions.sql` file.

