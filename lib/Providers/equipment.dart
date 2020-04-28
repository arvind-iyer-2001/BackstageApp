import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    @required this.id,
    @required this.title,
    this.color,
  });
}
const Categories = const [
  Category(
    id: 'mc00',
    title: 'All',
    color: Colors.green,
  ),
  Category(
    id: 'mc1',
    title: 'Cables',
    color: Colors.green,
  ),
  Category(
    id: 'mc2',
    title: 'Wired Microphones',
    color: Colors.green,
  ),
  Category(
    id: 'mc3',
    title: 'Wireless Microphones',
    color: Colors.green,
  ),
  Category(
    id: 'mc4',
    title: 'DI Box',
    color: Colors.green,
  ),
  Category(
    id: 'mc5',
    title: 'Monitor',
    color: Colors.green,
  ),
  Category(
    id: 'mc6',
    title: 'Mic Stand',
    color: Colors.green,
  ),
  Category(
    id: 'mc7',
    title: 'Monitors',
    color: Colors.green,
  ),
  Category(
    id: 'mc8',
    title: 'Amplifiers',
    color: Colors.green,
  ),
  Category(
    id: 'mc8',
    title: 'Sound Mixer',
    color: Colors.green,
  ),
  Category(
    id: 'mc8',
    title: 'd-Snake',
    color: Colors.green,
  ),
  Category(
    id: 'mc9',
    title: 'Light Mixer',
    color: Colors.green,
  ),
  // Category(
  //   id: 'mc10',
  //   title: '',
  //   color: Colors.green,
  // ),  
];

const SubCategories = const [
  Category(
    id: 'sc1',
    title: 'XLR Male to Female',
    color: Colors.orange,
  ),
  Category(
    id: 'sc2',
    title: 'XLR Male to Male',
    color: Colors.orange,
  ),
  Category(
    id: 'sc3',
    title: 'XLR Female to Female',
    color: Colors.orange,
  ),
  Category(
    id: 'sc4',
    title: 'TRS-3.5mm to TRS-3.5mm',
    color: Colors.orange,
  ),
  Category(
    id: 'sc5',
    title: 'TRS-3.5\' to 2 X XLR Female',
    color: Colors.orange,
  ),
  Category(
    id: 'sc6',
    title: 'TS-5\' to TS-5\'',
    color: Colors.orange,
  ),
  Category(
    id: 'sc7',
    title: 'TS-5\' to XLR Female',
    color: Colors.orange,
  ),
  Category(
    id: 'sc8',
    title: 'XLR Male to TS-5\'',
    color: Colors.orange,
  ),
  Category(
    id: 'sc9',
    title: 'Speak-On',
    color: Colors.orange,
  ),
  Category(
    id: 'sc10',
    title: 'RCA',
    color: Colors.orange,
  ),
  Category(
    id: 'sc11',
    title: 'Power Extensions',
    color: Colors.orange,
  ),
  Category(
    id: 'sc12',
    title: 'HDMI',
    color: Colors.orange,
  ),
  Category(
    id: 'sc13',
    title: 'VGA',
    color: Colors.orange,
  ),
  Category(
    id: 'sc14',
    title: 'XLR 5',
    color: Colors.orange,
  ),
  Category(
    id: 'sc15',
    title: 'Ahuja Wires',
    color: Colors.orange,
  ),
  Category(
    id: 'sc16',
    title: 'CAT-5',
    color: Colors.orange,
  ),
  Category(
    id: 'sc17',
    title: 'Cardioid Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc18',
    title: 'Super-Cardioid Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc19',
    title: 'Omni-Directional Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc20',
    title: 'Bi-Directional Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc21',
    title: 'Hypercardioid Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc22',
    title: 'Lobar Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc23',
    title: 'Dynamic Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc25',
    title: 'Condenser Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc26',
    title: 'Ribbon Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc27',
    title: 'Head-Worn Microphones',
    color: Colors.teal,
  ),
  Category(
    id: 'sc28',
    title: 'Contact Microphone',
    color: Colors.teal,
  ),
  Category(
    id: 'sc29',
    title: 'Active Monitor',
    color: Colors.teal,
  ),
  Category(
    id: 'sc30',
    title: 'Passive Monitor',
    color: Colors.teal,
  ),
  Category(
    id: 'sc31',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc32',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc33',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc34',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc35',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc36',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc37',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc38',
    title: '',
    color: Colors.teal,
  ),
  Category(
    id: 'sc39',
    title: '',
    color: Colors.teal,
  ),
];


class EquipmentItem with ChangeNotifier {
  @required final String title;
  @required List<String> categoryId;
  @required List<String> imageUrl;
  @required List<String> description;
  @required final String equipmentId;

  EquipmentItem({
    this.title,
    this.description,
    this.imageUrl,
    this.categoryId,
    this.equipmentId
  });
}

final List<EquipmentItem> _equipmentItems = [
    EquipmentItem(
      title: "Shure SM58 Wired",
      equipmentId: 'eId01',
      categoryId: [
        "mc2",
        "sc23",
        "sc17",
      ],
      description: [
        "Commonly used in live vocal applications.",
        "Has a low frequency boost when used close to the source.",
        "Internal shock mount to reduce handling noise.",
        "Frequency Response - 50 to 15,000 Hz",
        "Polar Pattern - Cardioid - Reduces pickup from the side and rear, helping to avoid feedback onstage",
        "Connector - Three-pin male XLR",
        "Impedance - Rated impedance is 150 ohms (300 ohms actual) for connection to microphone inputs rated low impedance",
        "Polarity - Positive pressure on diaphragm produces positive voltage on pin 2 with respect to pin 3",
        "Type - Dynamic Microphone",
        "No On-Off Switch"
      ],
      imageUrl: [
        "https://d2dfnis7z3ac76.cloudfront.net/shure_product_db/product_main_images/files/cf1/51c/44-/header_transparent/dc53d07c046536d8b078318e129876f2.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_503158fd-2aa5-4035-9fde-f687d47d6c04-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_ad42bed1-f837-4e2d-bb27-726c12c1bcd8-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_7e014e2c-0e64-4316-9359-a69f034adcd0-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_3cfab716-a05c-421a-a897-22f0dbb3418d-ENG.png",
      ],
    ),
    EquipmentItem(
      title: "Shure SM57 Wired",
      equipmentId: 'eId02',
      categoryId: [
        "mc2",
        "sc23",
        "sc17",
      ],
      description: [
        "Commonly used in live instrument sound reinforcement and studio recording.",
        "Type - Dynamic",
        "Frequency response - 40 to 15,000 Hz",
        "Polar pattern - Cardioid - Reduces the pickup of unwanted background sound and the generation of acoustic feedback.",
        "Impedance - Rated impedance is 150 ohms (300 ohms actual) for connection to microphone inputs rated low impedance",
        "Connector - Three-pin professional audio connector (male XLR type)"
        "The SM57 is a popular choice of musicians due to its sturdy construction and ability to work well with instruments that produce high sound pressure levels, such as percussion instruments and electric guitars. ",
        "SM57s reinforce the sound from guitar amplifiers.",
        "Features a balanced output, which helps to minimize electrical hum and noise pickup",
        // "",
      ],
      imageUrl: [
        "https://d2dfnis7z3ac76.cloudfront.net/shure_product_db/product_main_images/files/218/0f8/9b-/header_transparent/11cc244554e2d3880afecca5d6f63cc3.png",
        "https://d2dfnis7z3ac76.cloudfront.net/shure_product_db/product_images/files/f83/6c8/3c-/header_transparent/434a98f409c257b6eca61ef73795512f.png",
        "https://res.cloudinary.com/powerreviews/image/upload/c_fill,d_portal-no-product-image_ttlfpi.svg,f_auto,g_auto,h_400,q_auto,w_auto,z_0.5/d_portal-no-product-image_ttlfpi.svg/prod/socialCollection/i1nkzrrzbwudoctsfwhy",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_503158fd-2aa5-4035-9fde-f687d47d6c04-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_9cdd9a22-a4a1-4241-a428-f4421ae9973a-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_97d5aa0e-73fa-4584-b577-bc35f5d50fa7-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_d875dc79-861d-4af3-94b2-433b3b8bec5b-ENG.png",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_7acd2a4b-5d58-490c-811f-59403d4f2125-ENG.png"
      ],
    ),
    EquipmentItem(
      title: "Shure PG58 Wired",
      equipmentId: 'eId03',
      categoryId: [
        "mc2",
        "sc23",
        "sc17",
      ],
      description: [
        "Used for Vocals",
        "Polar Pattern - Cardioid - Reduces pickup from the side and rear, helping to avoid feedback onstage",
        "Connector - Three-pin male XLR",
        "Impedance - Rated impedance is 150 ohms (300 ohms actual) for connection to microphone inputs rated low impedance",
        "Polarity - Positive pressure on diaphragm produces positive voltage on pin 2 with respect to pin 3",
        "Type - Dynamic Microphone",
        "Has On-Off Switch"
        "Has an Internal shockmount, Pop filter",
        "Neodymium magnet produces high output"
      ],
      imageUrl: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQgnCUifNILRiQPu_Xbmxu7o-wjVZ9UGr-8-7NbfvyPgIdjOhYH&usqp=CAU",
        "https://images-na.ssl-images-amazon.com/images/I/71IgqE44dtL._SL1500_.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/413E0f5Jt3L._AC_.jpg",
        "https://s3.us-east-2.amazonaws.com/shure-pubs-staging/graphics/f_3cfab716-a05c-421a-a897-22f0dbb3418d-ENG.png",
        "",
        "",
        ""
      ],
    ),
    EquipmentItem(
      title: "XLR 5",
      equipmentId: 'eId04',
      categoryId: [
        "mc1",
        "",
        "",
        "",
        "",
        ""
      ],
      description: [
        "Not Gret",
        "Great",
        "Not Great",
        "Great",
        "Greatish",
        "Bleh"
      ],
      imageUrl: [
        // "",
        // "",
        // "",
        // "",
        // "",
        // ""
      ],
    ),
    EquipmentItem(
      title: "",
      equipmentId: 'eId05',
      categoryId: [
        "",
        "",
        "",
        "",
        "",
        ""
      ],
      description: [
        "",
        "",
        "",
        "",
        "",
        ""
      ],
      imageUrl: [
        "",
        "",
        "",
        "",
        "",
        ""
      ],
    ),
  ];

class EquipmentFunctions with ChangeNotifier {
  

  List<EquipmentItem> get equipmentItems {
    return [..._equipmentItems];
  }

  EquipmentItem findByItemId(String equipmentId) {
    return _equipmentItems.firstWhere((item) => item.equipmentId == equipmentId);
  }
  
  void addEquipmentItems(EquipmentItem newItem) {
    final newEquipmentItem = EquipmentItem(
      title: newItem.title,
      description: newItem.description,
      imageUrl: newItem.imageUrl,
      categoryId: newItem.categoryId,
      equipmentId: DateTime.now().toString(),
    );
    _equipmentItems.add(newEquipmentItem);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  void updateEquipmentItem(String equipmentId, EquipmentItem editedItem) {

  }
}