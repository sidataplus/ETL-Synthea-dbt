# ETL-Synthea-dbt

Using [dbt](https://www.getdbt.com) (data build tool) to convert Synthea synthetic data to OMOP Common Data Model in PostgreSQL

## Requirements

- dbt-core >= 1.0.0
- dbt-postgres >= 1.0.0
- sqlfluff >= 2.0.0
- sqlfluff-templater-dbt >= 2.0.0


## Set-up

1. Install dbt with Postgres adapter, sqlfluff and sqlfluff-templater-dbt

```
pip install dbt-postgres sqlfluff sqlfluff-templater-dbt
```

2. If the installation is successful, you should have dbt CLI accessible globally. To test run

```
dbt --version
```

3. Go to `~/.dbt/` (user home directory, i.e., not this repo directory), create `profiles.yml` with the example from `example.profiles.yml`.
   Fill in database credentials, read instructions in [Postgres Profile config](https://docs.getdbt.com/docs/core/connect-data-platform/postgres-setup).  
   dbt can write and read to one database connection at a time. _dbt is not an ETL tool, as it does just the T._


4. Test settings & DB connection, run

```
dbt debug

```

5. Install packages for macro

```
dbt deps
```

6. Write code. Learn more from [Official free online courses](https://www.getdbt.com/dbt-learn/).

7. We use [SQLFluff](https://sqlfluff.com) to make our SQL code clean and consistent.

Install SQLFluff and sqlfluff-templater-dbt with

```
pip install sqlfluff sqlfluff-templater-dbt
```

To lint SQL codes, run

```
sqlfluff lint .
```

To fix linting issues, run

```
sqlfluff fix .
```

or the following to force fix

```
sqlfluff fix -f .
```

8. To test whether the code is good on our database or not, compile the model with

```
dbt compile
```

(optional: with --models like `dbt run` below).

9. To run models,

- `dbt run` - regular run
- Model selection syntax ([source](https://docs.getdbt.com/docs/model-selection-syntax)). Specifying models can save you a lot of time by only running/testing the models that you think are relevant. However, there is a risk that you'll forget to specify an important upstream dependency so it's a good idea to understand the syntax thoroughly:
  - `dbt run --models modelname` - will only run modelname
  - `dbt run --models +modelname` - will run modelname and all parents
  - `dbt run --models modelname+` - will run modelname and all children
  - `dbt run --models +modelname+` - will run modelname, and all parents and children
  - `dbt run --models @modelname` - will run modelname, all parents, all children, AND all parents of all children
  - `dbt run --exclude modelname` - will run all models except modelname
  - Note that all of these work with folder selection syntax too:
    - `dbt run --models folder` - will run all models in a folder
    - `dbt run --models folder.subfolder` - will run all models in the subfolder
    - `dbt run --models +folder.subfolder` - will run all models in the subfolder and all parents

10. To run models with test, use

```
dbt build
```

(optional: with --models like `dbt run` above).

11. To generate doc, run `dbt docs generate`, serve by `dbt docs serve`. Or, run them together as

```
dbt docs generate && dbt docs serve --port 8080
```

## Other resources

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction), [reference](https://docs.getdbt.com/reference/dbt_project.yml), [best practices](https://docs.getdbt.com/guides/best-practices)
- dbt project maturity levels [repo](https://github.com/dbt-labs/dbt-project-maturity), [video](https://www.youtube.com/watch?v=jJFdVVzWCKI)
- GitLab's dbt [repo](https://gitlab.com/gitlab-data/analytics/-/tree/master/transform/snowflake-dbt)
