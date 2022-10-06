{%- macro map_concept(cdm_table="", vocabulary_id="", concept_code_field="") -%}

LEFT JOIN {{ source('vocab', 'concept') }} AS {{vocabulary_id}}_concept
ON 
    (
        {{cdm_table}}.{{concept_code_field}} = {{vocabulary_id}}_concept.concept_code
        AND {{vocabulary_id}}_concept.vocabulary_id = '{{vocabulary_id}}'
        --AND {{vocabulary_id}}_concept.standard_concept = 'S'
    )
    OR
	(
		{{cdm_table}}.{{concept_code_field}} = {{vocabulary_id}}_concept.concept_code
		AND {{vocabulary_id}}_concept.concept_code = 'No matching concept'
	)

{%- endmacro -%}