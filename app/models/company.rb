class Company < ApplicationRecord
  has_many :companies_pointers, dependent: :destroy
  validates :ticker, presence: true

  FINANCIAL_DEFINITION = {
    "Blank 1": {
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
    "Earnings per share": {
      "EPS": "Basic",
      "EPS Diluted": "Diluted",
    },
    "Shares used in computing earnings per share": {
      "Weighted Average Shs Out": "Basic",
      "Weighted Average Shs Out (Dil)": "Diluted",
    },
    "Blank 2": {
      "Preferred Dividends": "Preferred dividends",
      "Dividend per Share": "Dividend per share",
    },
    "Metrics": {
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
    "Blank 1": "format_millions",
    "Earnings per share": "format_round_two",
    "Shares used in computing earnings per share": "format_round_zero",
    "Blank 2": "format_round_two",
    "Metrics": "format_percentage"
  }

  def self.format_millions(number)
    number.to_f.round(0) / 1_000_000
  end

  def self.format_round_zero(number)
    number.to_f.round(0)
  end

  def self.format_round_two(number)
    number.to_f.round(2)
  end

  def self.format_percentage(number)
    (number.to_f * 100).round(2)
  end
end
