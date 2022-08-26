SELECT
    ROW_NUMBER()OVER(ORDER BY p.id) AS person_id,
    CASE UPPER(p.gender)
        WHEN 'M' THEN 8507
        WHEN 'F' THEN 8532
    END AS gender_concept_id,
    DATE_PART('year', p.birthdate) AS year_of_birth,
    DATE_PART('month', p.birthdate) AS month_of_birth,
    DATE_PART('day', p.birthdate) AS day_of_birth,
    p.birthdate AS birth_datetime,
    CASE UPPER(p.race)
        WHEN 'WHITE' THEN 8527
        WHEN 'BLACK' THEN 8516
        WHEN 'ASIAN' THEN 8515
        ELSE 0
    END AS race_concept_id,
    CASE
        WHEN UPPER(p.ethnicity) = 'HISPANIC' THEN 38003563
        WHEN UPPER(p.ethnicity) = 'NONHISPANIC' THEN 38003564
        ELSE 0
    END AS ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    p.id AS person_source_value,
    p.gender AS gender_source_value,
    0 AS gender_source_concept_id,
    p.race AS race_source_value,
    0 AS race_source_concept_id,
    p.ethnicity AS ethnicity_source_value,
    0 AS ethnicity_source_concept_id
FROM {{ source('synthea', 'patients') }} AS p
WHERE p.gender IS NOT NULL
