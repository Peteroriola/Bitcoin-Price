//
//  ViewController.swift
//  Bitcoin Price
//
//  Created by Peter Oriola on 07/02/2019.
//  Copyright © 2019 Peter Oriola. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let apiURL = "https://api.coindesk.com/v1/bpi/currentprice/CNY.json"
    
    
    
    let countryCurrencyArray = ["AED: United Arab Emirates Dirham", "AFN: Afghan Afghani", "ALL: Albanian Lek", "AMD: Armenian Dram", "ANG: Netherlands Antillean Guilder", "AOA: Angolan Kwanza", "ARS: Argentine Peso", "AUD: Australian Dollar", "AWG: Aruban Florin", "AZN: Azerbaijani Manat", "BAM: Bosnia-Herzegovina Convertible Mark","BBD: Barbadian Dollar", "BDT: Bangladeshi Taka","BGN: Bulgarian Lev", "BHD: Bahraini Dinar", "BIF: Burundian Franc", "BMD: Bermudan Dollar", "BND: Brunei Dollar", "BOB: Bolivian Boliviano", "BRL: Brazilian Real", "BSD: Bahamian Dollar", "BTC: Bitcoin","BTN: Bhutanese Ngultrum", "BWP: Botswanan Pula", "BYR: Belarusian Ruble", "BZD: Belize Dollar","CAD: Canadian Dollar", "CDF: Congolese Franc","CHF: Swiss Franc", "CLF: Chilean Unit of Account (UF)","CLP: Chilean Peso", "CNY: Chinese Yuan", "COP: Colombian Peso", "CRC: Costa Rican ColÛn", "CUP: Cuban Peso", "CVE: Cape Verdean Escudo", "CZK: Czech Republic Koruna", "DJF: Djiboutian Franc", "DKK: Danish Krone", "DOP: Dominican Peso", "DZD: Algerian Dinar", "EEK: Estonian Kroon", "EGP: Egyptian Pound", "ERN: Eritrean Nnakfa", "ETB: Ethiopian Birr", "EUR: Euro", "FJD: Fijian Dollar", "FKP: Falkland Islands Pound", "GBP: British Pound Sterling", "GEL: Georgian Lari", "GHS: Ghanaian Cedi", "GIP: Gibraltar Pound", "GMD: Gambian Dalasi", "GNF: Guinean Franc", "GTQ: Guatemalan Quetzal", "GYD: Guyanaese Dollar", "HKD: Hong Kong Dollar", "HNL: Honduran Lempira", "HRK: Croatian Kuna", "HTG: Haitian Gourde", "HUF: Hungarian Forint", "IDR: Indonesian Rupiah", "ILS: Israeli New Sheqel", "INR: Indian Rupee", "IQD: Iraqi Dinar", "IRR: Iranian Rial", "ISK: Icelandic KrÛna", "JEP: Jersey Pound", "JMD: Jamaican Dollar", "JOD: Jordanian Dinar", "JPY: Japanese Yen", "KES: Kenyan Shilling", "KGS: Kyrgystani Som", "KHR: Cambodian Riel", "KMF: Comorian Franc", "KPW: North Korean Won", "KRW: South Korean Won", "KWD: Kuwaiti Dinar", "KYD: Cayman Islands Dollar", "KZT: Kazakhstani Tenge", "LAK: Laotian Kip", "LBP: Lebanese Pound", "LKR: Sri Lankan Rupee", "LRD: Liberian Dollar", "LSL: Lesotho Loti", "LTL: Lithuanian Litas", "LVL: Latvian Lats", "LYD: Libyan Dinar", "MAD: Moroccan Dirham", "MDL: Moldovan Leu", "MGA: Malagasy Ariary", "MKD: Macedonian Denar", "MMK: Myanma Kyat", "MNT: Mongolian Tugrik", "MOP: Macanese Pataca", "MRO: Mauritanian Ouguiya", "MTL, Maltese Lira", "MUR: Mauritian Rupee", "MVR: Maldivian Rufiyaa", "MWK: Malawian Kwacha", "MXN: Mexican Peso", "MYR: Malaysian Ringgit", "MZN: Mozambican Metical", "NAD: Namibian Dollar", "NGN: Nigerian Naira", "NIO: Nicaraguan CÛrdoba", "NOK: Norwegian Krone", "NPR: Nepalese Rupee", "NZD: New Zealand Dollar", "OMR: Omani Rial", "PAB: Panamanian Balboa", "PEN: Peruvian Nuevo Sol", "PGK: Papua New Guinean Kina", "PHP: Philippine Peso", "PKR, Pakistani Rupee", "PLN: Polish Zloty", "PYG: Paraguayan Guarani", "QAR: Qatari Rial", "RON: Romanian Leu", "RSD: Serbian Dinar", "RUB: Russian Ruble", "RWF: Rwandan Franc", "SAR: Saudi Riyal", "SBD: Solomon Islands Dollar", "SCR: Seychellois Rupee", "SDG: Sudanese Pound", "SEK: Swedish Krona", "SGD: Singapore Dollar", "SHP: Saint Helena Pound", "SLL: Sierra Leonean Leone", "SOS: Somali Shilling", "SRD: Surinamese Dollar", "STD: Sao TomÈ and PrÌncipe Dobra", "SVC: Salvadoran ColÛn", "SYP: Syrian Pound", "SZL: Swazi Lilangeni", "THB: Thai Baht", "TJS: Tajikistani Somoni", "TMT: Turkmenistani Manat", "TND: Tunisian Dinar", "TOP: Tongan Pa?anga", "TRY: Turkish Lira", "TTD: Trinidad and Tobago Dollar", "TWD: New Taiwan Dollar", "TZS: Tanzanian Shilling", "UAH: Ukrainian Hryvnia", "UGX: Ugandan Shilling", "USD: United States Dollar", "UYU: Uruguayan Peso", "UZS: Uzbekistan Som", "VEF: Venezuelan BolÌvar Fuerte", "VND: Vietnamese Dong", "VUV: Vanuatu", "WST: Samoan Tala", "XAF: CFA Franc BEAC", "XAG: Silver (troy ounce)", "XAU: Gold (troy ounce)", "XBT: Bitcoin", "XCD: East Caribbean Dollar", "XDR: Special Drawing Rights", "XOF: CFA Franc BCEAO", "XPF: CFP Franc",  "YER: Yemeni Rial", "ZAR: South African Rand", "ZMK: Zambian Kwacha (pre-2013)", "ZMW: Zambian Kwacha", "ZWL: Zimbabwean Dollar"]
    
    
    let currencyIdentifierArray = ["AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTC", "BTN", "BWP", "BYR", "BZD", "CAD", "CDF", "CHF", "CLF", "CLP", "CNY", "COP", "CRC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EEK", "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MTL", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG", "XAU", "XBT", "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMK", "ZMW", "ZWL"]
    
    var appendApiURL = ""
    
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCurrencyArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryCurrencyArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currencyIdentifierArray[row]
        
       appendApiURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC\(selectedCurrency)"
        print(appendApiURL)
        
        getBitconData(url: appendApiURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    
    //MARK:- NETWORKING
    
    
    func  getBitconData(url: String) {
      
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Success! Got bitcoin Data")
                    
                    let bitcoinJSON : JSON = JSON(response.result.value as Any)
                  
                    
                    self.updateBitcoinData(json: bitcoinJSON)
                    
                }else {
                    print("error")
                    
                    self.currentPriceLabel.text = "Connection Issues"
                }
                
        }
        
        
    }

    //MARK:- JSON
    func updateBitcoinData(json : JSON) {
      
        
        
        if let bitcoinResult = json["ask"].double {
            currentPriceLabel.text = "\(bitcoinResult)"
            
            print(bitcoinResult)
        }
        else {
            currentPriceLabel.text = "Price not Available"
        }
        
        
    }
    
}

