--TODO(): reference this source from a variable configured in the config YAML

-- depends_on: {{ source('partner', 'campaigns') }}

SELECT * FROM {{ source('partner','campaigns') }}