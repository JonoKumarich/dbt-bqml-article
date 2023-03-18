import pandas as pd
from datetime import date, timedelta
import random
from itertools import product
from typing import TypedDict


CUSTOMER_IDS = list(range(100))
BASE_WEEK = date(2023, 2, 6)
WEEKS = [BASE_WEEK + timedelta(weeks=i) for i in range(4)]
random.seed(0)


class CustomerData(TypedDict):
    customer_id: int
    week_start_date: date
    weeks_since_last_shopped: int
    last_shop_spend_total: float


def generate_random_data(week: date, customer: int) -> CustomerData:
    weeks_since_last_shopped = random.randint(0, 52)
    last_shop_spend_total = random.random() * 1000
    
    return CustomerData(
        customer_id=customer, 
        week_start_date=week, 
        weeks_since_last_shopped=weeks_since_last_shopped, 
        last_shop_spend_total=last_shop_spend_total
    )


def generate_customer_dummy_data() -> None:
    customer_data = [
        generate_random_data(week, customer) for week, customer in product(WEEKS, CUSTOMER_IDS)
    ]
 
    customer_dataframe = pd.DataFrame(customer_data)
    
    customer_dataframe.to_csv("customer_data.csv", index=False)


if __name__ == "__main__":
    generate_customer_dummy_data()
