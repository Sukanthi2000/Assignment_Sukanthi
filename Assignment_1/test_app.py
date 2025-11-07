import unittest

class TestApp(unittest.TestCase):
    def test_sample(self):
        self.assertEqual(1 + 1, 2)
    
    def test_string(self):
        self.assertEqual("hello".upper(), "HELLO")