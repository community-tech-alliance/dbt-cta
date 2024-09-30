select Fee,
Date,
Amount
from {{ source("cta", "refunded_contributions_base") }}
