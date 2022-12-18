--TODO(): reference this source from a variable configured in the config YAML
SELECT * FROM {{ source('partner','campaigns') }}