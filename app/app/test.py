"""""
sample test 
"""
from django.test import SimpleTestCase

from app import cal

class CalcTests(SimpleTestCase):

    def test_add_numbers(self):
        res= cal.add(5,6)
        self.assertEqual(res, 11)

    def test_sub_num(self):
        res = cal.sub(10,15)
        self.assertEqual(res, 5)