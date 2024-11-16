# GTM Object Remapper

A custom template for Google Tag Manager that allows dynamic remapping of object keys in a data array.

## 📋 Description

This script enables renaming object keys within a data array in Google Tag Manager. It's particularly useful when you need to standardize key names coming from different data sources or adapt them to specific tracking requirements.

## 🚀 Features

- Handles both single objects, arrays of objects and object of objects
- Supports automatic conversion of single objects to arrays
- Manages nested objects
- Preserves original values during remapping
- Removes old keys after remapping

## 📥 Input

The script requires two main inputs:

### inputArray
An array of objects or a single object containing the data to be remapped.

### remapperValues
An array of objects with the following structure:
```javascript
[
  {
    "oldKey": "oldName",
    "newKey": "newName"
  }
]
```

## 📤 Output

Returns an array of objects with keys remapped according to the rules specified in `remapperValues`.

## 🔍 Example

### Input
```javascript
inputArray = [
  {
    "oldName": "value1",
    "otherKey": "value2"
  }
]

remapperValues = [
  {
    "oldKey": "oldName",
    "newKey": "newName"
  }
]
```

### Output
```javascript
[
  {
    "newName": "value1",
    "otherKey": "value2",
    ...originalObject
  }
]
```

## ⚙️ Validations

The script includes several validations:
- Checks that the input array is not empty
- Automatically handles both single objects and arrays of objects
- Verifies key existence before remapping

## 🔧 Installation

1. Create a new variable in the Variables section tag in Google Tag Manager
2. Click the three vertical dots in the top right corner and click Import
3. Configure the input variables `inputArray` and `remapperValues`
4. Test the tag in preview mode
5. Publish the changes

## 💻 Code Example

```javascript
const remapper = (object) => {
   remapperValues.forEach(row => {
     if(object.hasOwnProperty(row.oldKey)){
       object[row.newKey] = object[row.oldKey];
       object[row.oldKey] = undefined;
   }
   });
  return object;
};
```

## 📝 Notes

- Original keys are set to `undefined` after remapping
- The script does not preserve all non-remapped keys and their values
- Works with any valid JavaScript object structure

## 🤝 Contributing

Feel free to submit issues and enhancement requests through GitHub issues.

## 📜 License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

## ✨ Authors

Initial work by (Paolo Bietolini)[https://paolobietolini.com]