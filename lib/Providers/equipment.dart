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
  @required final List<String> categoryId;
  @required final List<String> imageUrl;
  @required final List<String> description;
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
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg",
        "https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg",
        "https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg",
        "https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg"
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
        "",
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
        "",
        "",
        "",
        "",
        "",
        ""
      ],
    ),
    EquipmentItem(
      title: "",
      equipmentId: 'eId04',
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
  
  void addEquipmentItems() {
    
  }
}