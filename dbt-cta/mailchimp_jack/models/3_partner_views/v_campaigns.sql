-- depends_on: {{ source('partner', 'campaigns') }}

SELECT * FROM {{ source('partner','campaigns') }}