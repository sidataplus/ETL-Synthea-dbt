SELECT
    row_number()OVER(ORDER BY p.person_id) AS condition_occurrence_id,
    p.person_id AS person_id,
    srctostdvm.target_concept_id AS condition_concept_id,
    c.start AS condition_start_date,
    c.start AS condition_start_datetime,
    c.stop AS condition_end_date,
    c.stop AS condition_end_datetime,
    38000175 AS condition_type_concept_id,
    cast(NULL AS varchar) AS stop_reason,
    cast(NULL AS integer) AS provider_id,
    fv.visit_occurrence_id_new AS visit_occurrence_id,
    fv.visit_occurrence_id_new + 1000000 AS visit_detail_id,
    c.code AS condition_source_value,
    srctosrcvm.source_concept_id AS condition_source_concept_id,
    NULL AS condition_status_source_value,
    0 AS condition_status_concept_id

FROM {{ source('synthea', 'conditions') }} AS c
INNER JOIN {{ ref('source_to_standard_vocab_map') }} AS srctostdvm
           ON srctostdvm.source_code = c.code
           AND srctostdvm.target_domain_id = 'Condition'
           AND srctostdvm.target_vocabulary_id = 'SNOMED'
           AND srctostdvm.source_vocabulary_id = 'SNOMED'
           AND srctostdvm.target_standard_concept = 'S'
           AND srctostdvm.target_invalid_reason IS NULL
INNER JOIN {{ ref('source_to_source_vocab_map') }} AS srctosrcvm
           ON srctosrcvm.source_code = c.code
           AND srctosrcvm.source_vocabulary_id = 'SNOMED'
           AND srctosrcvm.source_domain_id = 'Condition'
LEFT JOIN {{ ref('final_visit_ids') }} AS fv
          ON fv.encounter_id = c.encounter
INNER JOIN {{ ref('person') }} AS p
           ON c.patient = p.person_source_value
