___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Object Keys Remapper",
  "categories": ["UTILITY"],
  "description": "This code checks if inputArray is an array of objects. If not, it wraps it in an array. It then remaps the keys in each object using according the input values, returning the modified array.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inputArray",
    "displayName": "Input Data",
    "simpleValueType": true,
    "help": "Can be an array of objects [{}], an obect {} or an object of objects {{},{}}",
    "alwaysInSummary": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "PARAM_TABLE",
    "name": "remapperValues",
    "displayName": "Map Keys",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "oldKey",
          "displayName": "Original Key",
          "simpleValueType": true,
          "valueValidators": [
            {
              "type": "NON_EMPTY"
            }
          ]
        },
        "isUnique": true
      },
      {
        "param": {
          "type": "TEXT",
          "name": "newKey",
          "displayName": "New Key",
          "simpleValueType": true,
          "valueValidators": [
            {
              "type": "NON_EMPTY"
            }
          ]
        },
        "isUnique": true
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "newRowTitle": "Add the key name you want to change",
    "alwaysInSummary": true,
    "help": "Add the key name you want to change, eg: name \u003e item_name"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const log = require('logToConsole');
const Object = require('Object');
const remapperValues = data.remapperValues;
let inputArray = data.inputArray;
const getType = require('getType');

if(!inputArray.length) return;
const isObjectOfObjects = Object.keys(inputArray).every(key => getType(inputArray[key]) === 'object' && inputArray[key] !== null);

if(!isObjectOfObjects && getType(inputArray) === 'object') {inputArray = [inputArray];}
else if(isObjectOfObjects) {inputArray = Object.values(inputArray);}

const remapper = (object) => {
   remapperValues.forEach(row => {
     if(object.hasOwnProperty(row.oldKey)){
       object[row.newKey] = object[row.oldKey];
       object[row.oldKey] = undefined;
   }
   });
  return object;
};

return inputArray.map(item => remapper(item));


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Remap values
  code: |-
    mockData.remapperValues=[{ oldKey: 'price', newKey: 'item_price' }];

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: inputArray is an Object
  code: |-
    mockData.inputArray={
          item_id: "SKU_12345",
          item_name: "Stan and Friends Tee",
          affiliation: "Google Merchandise Store",
          coupon: "SUMMER_FUN",
          discount: 2.22,
          index: 0,
          location_id: "ChIJIQBpAG2ahYAR_6128GcTUEo",
          price: 10.03,
          quantity: 3
      };
    mockData.remapperValues=[{ oldKey: 'price', newKey: 'item_price' },
                              { oldKey: 'location_id', newKey: 'location' }];

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(undefined);
- name: inputArray is an Object of Objects
  code: |-
    mockData.inputArray={
      item1:{      item_id: "SKU_12345",
          item_name: "Stan and Friends Tee",
          affiliation: "Google Merchandise Store",
          coupon: "SUMMER_FUN",
          discount: 2.22,
          index: 0,},
      item2:{      item_id: "SKU_12345",
          item_name: "Stan and Friends Tee",
          affiliation: "Google Merchandise Store",
          coupon: "SUMMER_FUN",
          discount: 2.22,
          index: 0,}
      };
    mockData.remapperValues=[{ oldKey: 'item_name', newKey: 'name' },
                              { oldKey: 'affiliation', newKey: 'item_affiliation' }];

    let variableResult = runCode(mockData);

    assertThat(variableResult).isNotEqualTo(undefined);
- name: inputArray is Empty array
  code: |-
    mockData.inputArray = [];

    let variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(undefined);
- name: Wrong keys
  code: |-
    mockData.remapperValues=[{ oldKey: 'noKey', newKey: 'absolutelyNoKey' }];

    let variableResult = runCode(mockData);

    assertThat(variableResult).isNotEqualTo(undefined);
setup: |-
  let mockData =    {
    inputArray:[{
        item_id: "SKU_12345",
        item_name: "Stan and Friends Tee",
        affiliation: "Google Merchandise Store",
        coupon: "SUMMER_FUN",
        discount: 2.22,
        index: 0,
        item_brand: "Google",
        item_category: "Apparel",
        item_category2: "Adult",
        item_category3: "Shirts",
        item_category4: "Crew",
        item_category5: "Short sleeve",
        item_list_id: "related_products",
        item_list_name: "Related Products",
        item_variant: "green",
        location_id: "ChIJIQBpAG2ahYAR_6128GcTUEo",
        price: 10.03,
        quantity: 3
    }]
  };


___NOTES___

Created on 17/11/2024, 00:03:21


