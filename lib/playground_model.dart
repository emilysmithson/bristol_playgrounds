import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class Playground {
  String id;
  String name;
  String location;
  String description;
  List<dynamic> images;
  String address;
  Map<String, bool> features;
  Map<String, dynamic> user;
  LatLng coordinates;
  double distance;
  Map<String, dynamic> flare;
  bool playground;

  Playground(
      {@required this.id,
      @required this.playground,
      this.name,
      this.location,
      this.images,
      this.address,
      this.description,
      this.coordinates,
      this.features = const {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
      this.user = const {
        'visited': true,
        'favourite': false,
      },
      this.distance = 0.0,
      this.flare = const {
        'asset': '',
        'size': 150.0,
        'running_animation': '',
        'animation_ontap': '',
        'top': 100.0,
        'left': 100.0
      }});
}

List<Playground> playgrounds = [
  Playground(
    id: '0',
    playground: true,
    name: 'Cotham Gardens',
    location: 'Cotham',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2019/04/fullsizeoutput_9d.jpeg?w=625'
          'https://bristolplaygrounds.files.wordpress.com/2018/02/img_6229.jpg?w=264&h=353',
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_6243.jpg?w=308&h=411',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2976.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2946.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2954.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2956.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2971.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2019/04/img_2975.jpg?w=625'
    ],
    description:
        'This is a pretty little playground right next to the train station so if the play equipment isn\'t enough to keep you occupied, the regular trains going by might be. It\'s surrounded by beautiful mature trees and has an attractive obstacle course as well as a small sandpit so don\'t forget your bucket and spade! ',
    address: '33 Redland Grove, Bristol BS6 6PR',
    coordinates: LatLng(51.467866, -2.598957),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true
    },
    flare: {
      'size': 100.0,
      'asset': 'assets/cotham_gardens.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '1',
    playground: true,
    name: 'Lake Grounds',
    location: 'Portishead',
    images: [
      'https://images.archant.co.uk/polopoly_fs/1.3942145.1422981037!/image/image.jpg_gen/derivatives/landscape_630/image.jpg',
      'https://bristolplaygrounds.files.wordpress.com/2015/05/img_1407-0.jpg?w=624',
      'https://bristolplaygrounds.files.wordpress.com/2015/05/img_5288.jpg'
          'https://bristolplaygrounds.files.wordpress.com/2015/05/img_5291.jpg',
    ],
    description:
        'This playground has plenty to keep everyone occupied. As well as a lovely play area you can take a walk around the lake and feed the ducks (no bread please!) There\'s a cafe for refreshments as well as a toilet.',
    address: 'Portishead, Bristol BS20 7HX',
    coordinates: LatLng(51.489637, -2.774770),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': true,
      'sandpit': false,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/portishead.flr',
      'animation_ontap': 'Untitled',
      'running_animation': 'Blinking'
    },
  ),
  Playground(
    id: '2',
    playground: true,
    name: 'Blaise Castle',
    location: "Henbury",
    images: [
      'https://www.freeparks.co.uk/wp-content/uploads/2016/01/Blaise_Estate_064.jpg',
      'https://bristolplaygrounds.files.wordpress.com/2015/05/img_7880.jpg?w=624',
      'https://bristolplaygrounds.files.wordpress.com/2015/05/img_7847.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-s/13/9c/52/a3/photo4jpg.jpg'
    ],
    description:
        'Set in stunning scenery on the Blaise Estate, this is one of the biggest playgrounds in Bristol with play equipment to suit everyone. It has a giant spider\'s web, a double height swing, two castles to climb, an aerial obstacle course, sandpit with pirate ship and plenty more. If you could possibly get bored by the playground there\'s also a cafe and lots of stunning walks nearby. Climb the hill to the old folly or wonder down to the river to find the stepping stones.',
    address: '19A Kings Weston Rd, Bristol BS10 7QT',
    coordinates: LatLng(51.505704, -2.634560),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 200.0,
      'asset': 'assets/blaise_castle.flr',
      'running_animation': 'flag',
      'animation_ontap': 'sliding',
    },
  ),
  Playground(
    id: '3',
    playground: true,
    name: 'Redland Green',
    location: 'Redland',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/03/img_6181.jpg',
      'https://bristolplaygrounds.files.wordpress.com/2015/03/img_6183.jpg?w=225&h=300'
    ],
    description: 'Set in the middle of this lovely green space this small playground has a lovely sandpit, witches hat, swings, zipwire and rocking elephants.',
    address: 'Redland Ct Rd, Bristol BS6 7EH',
    coordinates: LatLng(51.473690, -2.606140),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 100.0,
      'asset': 'assets/redland_green.flr',
      'running_animation': 'Untitled',
      'animation_ontap': '',
    },
  ),

  Playground(
    id: '4',
    name: 'Avonmouth',
    location: 'Avonmouth',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4218.jpg?w=624',
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4210.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4211.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4213.jpg?w=625',
      'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4214.jpg?w=625'
    ],
    address: 'St Andrew\'s Rd, Bristol BS11 9EL',
    description:
        'A lovely little playground in Avonmouth with a great variety of equipment. It features a small obstacle course, climbing frame and rocking motorbike.',
    coordinates: LatLng(51.500495, -2.697677),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    user: {'favourite': false, 'visited': true},
    flare: {
      'size': 150.0,
      'asset': 'assets/avonmouth.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '21',
    name: 'Victoria Park',
    location: 'Bedminster',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2016/01/img_9856.jpg?w=625'
    ],
    description: 'This beautiful park ',
    address: '12 Hill Ave, Bedminster, Bristol BS3 4SN',
    coordinates: LatLng(51.439923, -2.589059),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': true,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/victoria_park_bristol.flr',
      'animation_ontap': 'Untitled',
    },
  ),
  Playground(
    id: '6',
    playground: true,
    name: 'Netham Park',
    location: 'Redfield',
    images: [
      'https://www.freeparks.co.uk/wp-content/uploads/2016/01/netham-1.jpg',
      'https://www.freeparks.co.uk/wp-content/uploads/2016/01/netham-2.jpg',
      'https://www.freeparks.co.uk/wp-content/uploads/2016/01/netham-3.jpg',
      'https://www.freeparks.co.uk/wp-content/uploads/2016/01/netham-1.jpg',
    ],
    description: 'There are two playgrounds to discover here.',
    address: 'Hill Avenue, Bedminster, BS3 4SN',
    coordinates: LatLng(51.455151, -2.557324),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/netham.flr',
      'animation_ontap': 'sliding',
      'running_animation': 'blinking',
      'size': 100.0
    },
  ),
  Playground(
    id: '7',
    playground: true,
    name: 'Brandon Hill',
    location: 'Clifton',
    images: [
      'https://visitbristol.co.uk/imageresizer/?image=%2fdmsimgs%2foriginal_350142611.jpg&action=ProductDetailNew',
    ],
    description: '',
    address: 'Great George Street, Bristol, BS1 5RR',
    coordinates: LatLng(51.452122, -2.605930),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/brandon_hill.flr',
    },
  ),
  Playground(
    id: '8',
    name: 'Canford Park',
    playground: true,
    location: 'Westbury-On-Trym',
    images: [
      'https://visitbristol.co.uk/imageresizer/?image=%2fdmsimgs%2fCanford%20park%20018_1237944797.JPG&action=ProductDetailNew',
    ],
    description: '',
    address: 'Canford Lane, Westbury-on-Trym, BS9 3NX',
    coordinates: LatLng(51.493380, -2.625832),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/canford_park.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '9',
    location: 'Clifton',
    playground: true,
    name: 'Clifton',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/04/img_7059.jpg?w=624'
    ],
    description: '',
    address: ' Clifton, Bristol BS8 3LX',
    coordinates: LatLng(51.456544, -2.624860),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 250.0,
      'asset': 'assets/clifton.flr',
      'animation_ontap': 'Untitled'
    },
  ),

  Playground(
    id: '10',
    name: 'Felix Road',
    playground: true,
    location: 'Easton',
    images: [
      'https://visitbristol.co.uk/imageresizer/?image=%2Fdmsimgs%2Fvb_3_1157317906.jpg&action=ProductDetailNew'
    ],
    description: '',
    address: 'Felix Rd, Easton, Bristol BS5 0JW',
    coordinates: LatLng(51.463014, -2.567943),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'size': 250.0,
      'asset': 'assets/felix_road.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '11',
    name: 'Greville Smyth',
    playground: true,
    location: 'Ashton Gate',
    images: [
      'https://visitbristol.co.uk/imageresizer/?image=%2fdmsimgs%2fgrevilly-smyth-park1_458019605.jpg&action=ProductDetailNew'
    ],
    description: '',
    address: 'Bristol BS3 2EQ',
    coordinates: LatLng(51.442979, -2.620596),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/greville_smyth.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '12',
    name: 'Hengrove',
    location: 'Hengrove',
    playground: true,
    images: [
      'https://i.pinimg.com/originals/09/80/fc/0980fca8c8562a1368433d4f4166db50.jpg'
    ],
    description: '',
    address: 'Hengrove, Bristol BS14 0AP',
    coordinates: LatLng(51.415276, -2.584559),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': true,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 250.0,
      'asset': 'assets/hengrove.flr',
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
      id: '13',
      name: 'Horfield Common',
      playground: true,
      location: 'Horfield',
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2015/03/img_4775-0.jpg?w=624'
      ],
      description: '',
      address: 'Hengrove, Bristol BS14 0AP',
      coordinates: LatLng(51.485373, -2.594317),
      features: {
        'cafe': true,
        'toilet': true,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
    flare: {
      'size': 150.0,
      'asset': 'assets/horfield.flr',
      'animation_ontap': 'Untitled'
    },),
  Playground(
    id: '14',
    name: 'Kings Head Lane',
    playground: true,
    location: 'Bedminster Down',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2016/08/img_5417.jpg?w=624'
    ],
    description: '',
    address: '81-87 Kings Head Ln, Bedminster Down, Bristol BS13 7DA',
    coordinates: LatLng(51.418656, -2.621110),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/kings_head_lane.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
      id: '15',
      name: 'Lamplighters',
      playground: true,
      location: 'Shirehampton',
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4203.jpg?w=624'
      ],
      description: '',
      address: 'Station Rd, Shirehampton, Bristol BS11 9XA',
      coordinates: LatLng(51.482879, -2.681375),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': true,
      },
    flare: {
      'size': 150.0,
      'asset': 'assets/lamplighters.flr',
      'running_animation': 'Untitled'
    },),
  Playground(
    id: '16',
    name: 'Oldbury Court Estate',
    location: 'Fishponds',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/04/img_7280.jpg?w=225&h=300'
    ],
    description: '',
    address: 'Oldbury Ct Rd, Fishponds, Bristol BS16 2JH',
    coordinates: LatLng(51.488351, -2.528569),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': true,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 200.0,
      'asset': 'assets/oldbury_court_estate.flr',
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
    id: '17',
    name: 'Redcatch Park',
    playground: true,
    location: 'Knowle',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/07/img_9296.jpg?w=624'
    ],
    description: '',
    address: 'Broadwalk, Bristol, BS4 2RD',
    coordinates: LatLng(51.434249, -2.571662),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'size': 250.0,
      'asset': 'assets/redcatch.flr',
      'animation_ontap': 'Untitled'
    },
  ),
//  Playground(
//      id: '18',
//      name: 'Southmead Adventure Playground',
//      images: [
//        'https://www.familiesonline.co.uk/images/default-source/national/southmead-adventure-playground-in-bristol-min.png?sfvrsn=524e219d_0'
//      ],
//      description: '',
//      address: 'Doncaster Rd, Bristol BS10 5PP',
//      coordinates: LatLng(51.499395, -2.603408),
//      features: {
//        'cafe': true,
//        'toilet': true,
//        'waterplay': true,
//        'duckpond': false,
//        'sandpit': true,
//      }),
  Playground(
      id: '19',
      name: 'St Andrews',
      location: 'St Andrews',
      playground: true,
      images: ['http://www.afla.co.uk/images/CH/standrews/photo.jpg'],
      description: '',
      address: 'Effingham Rd, Bishopston, Bristol BS6 5AX',
      coordinates: LatLng(51.473116, -2.586395),
      features: {
        'cafe': true,
        'toilet': true,
        'waterplay': true,
        'duckpond': false,
        'sandpit': true,
      },
    flare: {
      'size': 200.0,
      'asset': 'assets/st_andrews.flr',
      'running_animation': 'Untitled',
    },),
  Playground(
    id: '20',
    name: 'St George',
    location: 'St George',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/03/img_4743.jpg?w=225&h=300'
    ],
    description: '',
    address: 'Church Rd, Whitehall, Bristol BS5 7AA',
    coordinates: LatLng(51.461326, -2.547402),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': true,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/st_george.flr',
      'running_animation': 'puffing',
      'animation_ontap': 'sliding',
    },
  ),

//  Playground(
//      id: '22',
//      name: 'Arnos Court Park',
//      images: ['https://www.brislington.org/apag/park0815sm.jpg'],
//      description: '',
//      address: '2 Hampstead Rd, Brislington, Bristol BS4 3HJ',
//      coordinates: LatLng(51.440360, -2.560493),
//      features: {
//        'cafe': false,
//        'toilet': false,
//        'waterplay': false,
//        'duckpond': false,
//        'sandpit': true,
//      }),
//  Playground(
//      id: '23',
//      name: 'Gores Marsh',
//      images: [
//        'https://bristolplaygrounds.files.wordpress.com/2015/06/img_8014.jpg?w=624'
//      ],
//      description: '',
//      address: 'Bedminster, Bristol BS3 2LN',
//      coordinates: LatLng(51.436385, -2.619381),
//      features: {
//        'cafe': false,
//        'toilet': false,
//        'waterplay': false,
//        'duckpond': false,
//        'sandpit': false,
//      }),
//  Playground(
//      id: '24',
//      name: 'Crow Lane',
//      images: [
//        'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4287-medium.jpg?w=625'
//      ],
//      description: '',
//      address: 'Crow Ln, Henbury, Bristol BS10 7HL',
//      coordinates: LatLng(51.508376, -2.623831),
//      features: {
//        'cafe': false,
//        'toilet': false,
//        'waterplay': false,
//        'duckpond': false,
//        'sandpit': false,
//      }),
//  Playground(
//      id: '25',
//      name: 'The Vench',
//      images: [
//        'https://i1.wp.com/thevench.co.uk/wp-content/uploads/2019/07/BW3A8914.jpg?resize=700%2C467&ssl=1'
//      ],
//      description: '',
//      address: 'Romney Ave, Lockleaze, Bristol BS7 9TB',
//      coordinates: LatLng(51.493187, -2.559953),
//      features: {
//        'cafe': true,
//        'toilet': true,
//        'waterplay': false,
//        'duckpond': false,
//        'sandpit': false,
//      }),
  Playground(
    id: '26',
    name: 'Mowbray Park',
    location: 'Stockwood',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2018/05/img_0291-medium.jpg?w=624'
    ],
    description: '',
    address: '16 Mowbray Rd, Knowle,  Bristol BS14 9HD',
    coordinates: LatLng(51.422102, -2.560923),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/mobray.flr',
      'animation_ontap': 'Untitled',
    },
  ),
//  Playground(
//      id: '27',
//      name: 'St Paul\'s Adventure Playground',
//      images: [
//        'https://bristolplaygrounds.files.wordpress.com/2015/05/img_7713.jpg?w=624'
//      ],
//      description: '',
//      address: 'Fern St, St Paul\'s, Bristol BS2 9LN',
//      coordinates: LatLng(51.464776, -2.577895),
//      features: {
//        'cafe': true,
//        'toilet': true,
//        'waterplay': true,
//        'duckpond': false,
//        'sandpit': true,
//      }),
  Playground(
      id: '28',
      name: 'Troopers Hill',
      location: 'St George',
      playground: true,
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4348-medium.jpg?w=625'
      ],
      description: '',
      address: '9 Greendown, Bristol BS5 8BS',
      coordinates: LatLng(51.458069, -2.536033),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
    flare: {
      'size': 150.0,
      'asset': 'assets/troopers_hill.flr',
      'running_animation': 'Untitled',
    },),
//  Playground(
//      id: '29',
//      name: 'Clevedon',
//      images: [
//        'https://www.freeparks.co.uk/wp-content/uploads/2018/08/IMG_5359.jpg'
//      ],
//      description: '',
//      address: 'Salthouse Rd, Clevedon BS21 7TR',
//      coordinates: LatLng(51.434703, -2.868830),
//      features: {
//        'cafe': true,
//        'toilet': true,
//        'waterplay': true,
//        'duckpond': false,
//        'sandpit': true,
//      }),
  Playground(
      id: '30',
      name: 'Pittville Park',
      location: 'Cheltenham',
      playground: true,
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4107.jpg?w=624'
      ],
      description: '',
      address: 'Evesham Rd, Cheltenham GL52 3AB',
      coordinates: LatLng(51.910698, -2.068723),
      features: {
        'cafe': true,
        'toilet': true,
        'waterplay': false,
        'duckpond': true,
        'sandpit': true,
      },
    flare: {
      'asset': 'assets/pittville.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '31',
    name: 'Mundy Playing Fields',
    location: 'Thornbury',
    playground: true,
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2016/08/img_5669.jpg?w=624'
    ],
    description: '',
    address: 'Thornbury, Bristol BS35 2AL',
    coordinates: LatLng(51.606478, -2.529603),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': true,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'asset': 'assets/mundy_playing_fields.flr',
      'size': 200.0,
      'animation_ontap': 'Untitled'
    },
  ),
//  Playground(
//    id: '32',
//    playground: true,
//    name: 'Royal Victoria',
//    location: 'Bath',
//    images: [
//      'https://bristolplaygrounds.files.wordpress.com/2015/07/img_2149.jpg?w=624'
//    ],
//    description: '',
//    address: 'Bath BA1 2LZ',
//    coordinates: LatLng(51.385797, -2.376246),
//    features: {
//      'cafe': true,
//      'toilet': true,
//      'waterplay': false,
//      'duckpond': true,
//      'sandpit': true,
//    },
//    flare: {'asset': 'assets/royal_victoria_bath.flr', 'size': 150.0},
//  ),
  Playground(
      id: '33',
      name: 'Kingsgate Park',
      playground: true,
      location: 'Yate',
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2018/03/img_47001.jpg?w=624'
      ],
      description: '',
      address: 'Sundridge Park, Yate, Bristol BS37 4EP',
      coordinates: LatLng(51.534272, -2.412743),
      features: {
        'cafe': true,
        'toilet': true,
        'waterplay': true,
        'duckpond': true,
        'sandpit': true,
      },
    flare: {
      'asset': 'assets/kingsgate.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },),
//  Playground(
//      id: '34',
//      name: 'Keynsham Memorial Park',
//      images: [
//        'https://bristolplaygrounds.files.wordpress.com/2015/03/img_6639.jpg?w=270&h=360'
//      ],
//      description: '',
//      address: 'Bath Hill, Keynsham, Bristol BS31 1HL',
//      coordinates: LatLng(51.414364, -2.495010),
//      features: {
//        'cafe': true,
//        'toilet': true,
//        'waterplay': false,
//        'duckpond': true,
//        'sandpit': false,
//      }),
  Playground(
      id: '35',
      name: 'Monks Park',
      playground: true,
      location: 'Southmead',
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2018/02/img_4276-medium.jpg?w=624'
      ],
      description: '',
      address: '60 Kenmore Cres, Bristol BS7 0TR',
      coordinates: LatLng(51.500551, -2.587077),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
    flare: {
      'asset': 'assets/monks_park.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },),
  Playground(
    id: '36',
    name: 'Page Park',
    playground: true,
    location: 'Stapleton',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2018/05/img_0502.jpg?w=625'
    ],
    description: '',
    address: '60 Kenmore Cres, Bristol BS7 0TR',
    coordinates: LatLng(51.482799, -2.497919),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'asset': 'assets/page_park.flr',
      'size': 150.0,
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
    id: '37',
    name: 'Elm Park',
    playground: true,
    location: 'Filton',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/10/img_0937.jpg?w=300&h=225'
    ],
    description: '',
    address: 'Elm Park, Filton, Bristol BS34 7PS',
    coordinates: LatLng(51.506859, -2.573659),
    features: {
      'cafe': true,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/elm_park.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },
  ),
  Playground(
      id: '38',
      name: 'Gainsborough Square',
      playground: true,
      location: 'Lockleaze',
      images: [
        'http://www.newleafstudio.com/images/LEAF_project_gainsborough/03_Gainsborough_IMG_5954.jpg'
      ],
      description: '',
      address: 'Gainsborough Square, Lockleaze, Bristol BS7 9XA',
      coordinates: LatLng(51.490299, -2.563094),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
    flare: {
      'asset': 'assets/gainsborough_square.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },),
  Playground(
    id: '39',
    playground: true,
    name: 'Perret\'s Park',
    location: 'Totterdown',
    images: [
      'https://bristolplaygrounds.files.wordpress.com/2015/04/img_5550.jpg'
    ],
    description: '',
    address: '2 Bayham Rd, Bristol BS4 2EA',
    coordinates: LatLng(51.438187, -2.578262),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/perrets_park.flr',
      'running_animation': 'Untitled',
      'size': 150.0,
    },
  ),
//  Playground(
//      id: '40',
//      name: 'Old Quarry Park',
//      images: [
//        'https://bristolmum.files.wordpress.com/2014/06/dsc04767.jpg?w=470&h=312'
//      ],
//      description: '',
//      address: 'Henleaze Rd, Bristol BS9 4AS',
//      coordinates: LatLng(51.491240, -2.607983),
//      features: {
//        'cafe': false,
//        'toilet': false,
//        'waterplay': false,
//        'duckpond': false,
//        'sandpit': false,
//      }),
  Playground(
      id: '41',
      name: 'Victoria Park Cardiff',
      location: 'Cardiff',
      playground: true,
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2016/08/img_5823-1.jpg'
      ],
      description: '',
      address: 'Victoria Park Rd E, Cardiff CF5 1EH',
      coordinates: LatLng(51.484029, -3.218790),
      features: {
        'cafe': true,
        'toilet': true,
        'waterplay': true,
        'duckpond': false,
        'sandpit': false,
      },
      flare: {
        'asset': 'assets/victoria_cardiff.flr',
        'running_animation': 'Untitled',
        'size': 150.0
      }),
  Playground(
      id: '42',
      name: 'Stoke Lodge',
      location: 'Stoke Bishop',
      playground: true,
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2015/03/img_3968.jpg?w=625'
      ],
      description: '',
      address: 'Shirehampton Road, BS9 1BN',
      coordinates: LatLng(51.485503, -2.637930),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': false,
      },
      flare: {
        'asset': 'assets/stoke_lodge.flr',
        'animation_ontap': 'Untitled',
        'size': 150.0
      }),
  Playground(
      id: '43',
      name: 'Victory  Park',
      location: 'Brislington  ',
      playground: true,
      images: [
        'https://bristolplaygrounds.files.wordpress.com/2015/03/img_3968.jpg?w=625'
      ],
      description: '',
      address: '77 School Rd, Brislington, Bristol BS4 4NE',
      coordinates: LatLng(51.437123, -2.543126),
      features: {
        'cafe': false,
        'toilet': false,
        'waterplay': false,
        'duckpond': false,
        'sandpit': true,
      },
      flare: {
        'asset': 'assets/victory_park.flr',
        'running_animation': 'Untitled',
        'size': 150.0
      }),

  Playground(
      id: '100',
      location: '',
      playground: false,
      name: 'Duckpond',
      user: {
        'visited': true,
      },
      flare: {
        'asset': 'assets/Duckpond.flr',
        'running_animation': 'Untitled',
        'size': 200.0
      }),
  Playground(id: '101', playground: false, location: '', name: 'Swing', user: {
    'visited': true,
  }, flare: {
    'asset': 'assets/swing_character.flr',
    'running_animation': 'Swing',
    'size': 100.0
  }),
];

getDistance() async {
  Position currentPosition = await Geolocator().getCurrentPosition();
  for (int i = 0; i < playgrounds.length; i++) {
    if (playgrounds[i].playground) {
      double endLatitude = playgrounds[i].coordinates.latitude;
      double endLongitude = playgrounds[i].coordinates.longitude;
      playgrounds[i].distance = await Geolocator().distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              endLatitude,
              endLongitude) /
          1000;
    }
  }
}

Future<int> checkDistance() async {
  Position currentPosition = await Geolocator().getCurrentPosition();
  for (int i = 0; i < playgrounds.length; i++) {
    if (playgrounds[i].playground) {
      double endLatitude = playgrounds[i].coordinates.latitude;
      double endLongitude = playgrounds[i].coordinates.longitude;
      playgrounds[i].distance = await Geolocator().distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              endLatitude,
              endLongitude) /
          1000;
      if (playgrounds[i].distance < 0.1) {
        print(playgrounds[i].name);
        return i;
      }
    }
  }
  return null;
}

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE playgrounds (
                id INTEGER PRIMARY KEY,
                visited INTEGER NOT NULL,
                favourite INTEGER NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<int> insert(int i) async {
    Database db = await database;
    int id = await db.insert('playgrounds', {
      'id': playgrounds[i].id,
      'visited': playgrounds[i].user['visited'] ? 1 : 0,
      'favourite': playgrounds[i].user['favourite'] ? 1 : 0
    });
    return id;
  }

//  Future<int> queryWord(int id) async {
//    Database db = await database;
//    List<Map> maps = await db.query(tableWords,
//        columns: [columnId, columnWord, columnFrequency],
//        where: '$columnId = ?',
//        whereArgs: [id]);
//    if (maps.length > 0) {
//      return Word.fromMap(maps.first);
//    }
//    return null;
//  }

// TODO: queryAllWords()
  Future<List<Map>> queryAllPlaygrounds() async {
    Database db = await database;
    List<Map> maps = await db.query(
      'playgrounds',
    );
    if (maps.length > 0) {
      return maps;
    }
    return null;
  }

  deleteLast() async {
    Database db = await database;
    List<Map> maps = await db.query(
      'playgrounds',
    );
    if (maps.length > 0) {
      return await db.delete('playgrounds');
    }
    return null;
  }
//  update(String word, int id) async{
//    Database db = await database;
//    db.rawUpdate('UPDATE $tableWords SET $columnWord = ? WHERE $columnId = ?',
//        [word, id]);
//  }

  getUserDb() async {
    Database db = await database;

    List<Map> map = await db.query(
      'playgrounds',
    );

    for (int i = 0; i < playgrounds.length; i++) {
      if (playgrounds[i].playground) {
        playgrounds.replaceRange(i, i + 1, [
          Playground(
            id: playgrounds[i].id,
            name: playgrounds[i].name,
            playground: playgrounds[i].playground,
            location: playgrounds[i].location,
            images: playgrounds[i].images,
            description: playgrounds[i].description,
            address: playgrounds[i].address,
            coordinates: playgrounds[i].coordinates,
            features: playgrounds[i].features,
            flare: playgrounds[i].flare,
            user: {
              'visited': map[i]['visited'] == 0 ? false : true,
              'favourite': map[i]['favourite'] == 0 ? false : true,
            },
          ),
        ]);
      }
    }
    return map;
  }

  deleteDB() async {
    Database db = await database;
    db.delete('playgrounds');
  }

  updateFavouritesOrVisited(int i, bool favourite) async {
    playgrounds.replaceRange(i, i + 1, [
      Playground(
          id: playgrounds[i].id,
          name: playgrounds[i].name,
          playground: playgrounds[i].playground,
          location: playgrounds[i].location,
          images: playgrounds[i].images,
          description: playgrounds[i].description,
          address: playgrounds[i].address,
          coordinates: playgrounds[i].coordinates,
          features: playgrounds[i].features,
          flare: playgrounds[i].flare,
          user: {
            'visited': favourite
                ? playgrounds[i].user['visited']
                : !playgrounds[i].user['visited'],
            'favourite': favourite
                ? !playgrounds[i].user['favourite']
                : playgrounds[i].user['favourite']
          })
    ]);
    Database db = await database;
    if (favourite) {
      db.rawUpdate('UPDATE playgrounds SET favourite = ? WHERE id = ?',
          [playgrounds[i].user['favourite'] ? 1 : 0, playgrounds[i].id]);
    } else {
      db.rawUpdate('UPDATE playgrounds SET visited = ? WHERE id = ?',
          [playgrounds[i].user['visited'] ? 1 : 0, playgrounds[i].id]);
    }
  }
}
