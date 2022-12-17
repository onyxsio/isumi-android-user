// class ShipTo {
//   final String name;
//   final String street;
//   final String city;
//   final String country;
//   final String postalCode;
//   final String state;
//   final String text;
//   ShipTo({
//     required this.name,
//     required this.street,
//     required this.city,
//     required this.country,
//     required this.postalCode,
//     required this.state,
//     required this.text,
//   });

//   static ShipTo formjson(Map<String, dynamic> data) {
//     return ShipTo(
//         name: data['name'],
//         street: data['street'],
//         city: data['city'],
//         country: data['country'],
//         postalCode: data['postalCode'],
//         state: data['state'],
//         text: data['text']);
//   }

//   Map<String, dynamic> toJson(ShipTo data) {
//     return {
//       'name': data.name,
//       'street': data.street,
//       'city': data.city,
//       'country': data.country,
//       'postalCode': data.postalCode,
//       'state': data.state,
//       'text': data.text
//     };
//   }
// }

// // "street": "22 Rue du Grenier Saint-Lazare",
// //     "postalCode": "75003",
// //     "city": "Paris",
// //     "countryCode": "FRA",
// //     "country": "France",
// //     "text": "22 Rue du Grenier Saint-Lazare\n75003 Paris\nFrance"