class Company < ApplicationRecord
  has_many :companies_pointers, dependent: :destroy
  validates :ticker, presence: true

  FINANCIAL_DEFINITION = {
    "INCOME": {
      "Revenue": "Net sales",
      "Cost of Revenue": "Cost of sales",
      "Gross Profit": "Gross Margin",
      "R&D Expenses": "Research and development",
      "SG&A Expense": "Selling, general and administrative",
      "Operating Expenses": "Total operating expenses",
      "EBITDA": "EBITDA",
      "EBIT": "EBIT",
      "Operating Income": "Operating Income",
      "Interest Expense": "Other Income(expense), net",
      "Income Tax Expense": "Income Tax Expense",
      "Earnings before Tax": "Income before provision for income taxes",
      "Net Income - Non-Controlling int": "Net income from non-controlling int",
      "Net Income - Discontinued ops": "Net income from discontinued ops",
      "Net Income": "Net income",
      "Net Income Com": "Net income com",
      "Consolidated Income": "Consolidated income"
    },
    "EARNINGS PER SHARE": {
      "EPS": "Basic",
      "EPS Diluted": "Diluted",
    },
    "SHARES USED IN COMPUTING EARNINGS PER SHARE": {
      "Weighted Average Shs Out": "Basic (in thousands)",
      "Weighted Average Shs Out (Dil)": "Diluted (in thousands)",
    },
    "DIVIDENDS": {
      "Preferred Dividends": "Preferred dividends",
      "Dividend per Share": "Dividend per share",
    },
    "METRICS": {
      "Revenue Growth": "Revenue growth",
      "Gross Margin": "Gross margin",
      "EBITDA Margin": "EBITDA margin",
      "EBIT Margin": "EBIT margin",
      "Profit Margin": "Profit margin",
      "Free Cash Flow margin": "Free cash flow margin",
      "Earnings Before Tax Margin": "Earnings before tax margin",
      "Net Profit Margin": "Net profit margin"
    }
  }

  GROUP_NUMBER_FORMAT = {
    "INCOME": "format_millions",
    "EARNINGS PER SHARE": "format_round_two",
    "SHARES USED IN COMPUTING EARNINGS PER SHARE": "format_thousands_round_zero",
    "DIVIDENDS": "format_round_two",
    "METRICS": "format_percentage"
  }

  def self.format_millions(number)
    number.to_f.round(0) / 1_000_000
  end

  def self.format_thousands_round_zero(number)
    number.to_f.round(0) / 1_000
  end

  def self.format_round_two(number)
    number.to_f.round(2)
  end

  def self.format_percentage(number)
    (number.to_f * 100).round(2)
  end
end
