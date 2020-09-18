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
  String address;
  Map<String, bool> features;
  Map<String, dynamic> user;
  LatLng coordinates;
  double distance;
  Map<String, dynamic> flare;
  bool playground;
  String secretCode;

  Playground(
      {@required this.id,
        @required this.playground,
        this.name,
        this.location,
        this.address,
        this.description,
        this.coordinates,
        @required this.secretCode,
        this.features = const {
          'cafe': false,
          'toilet': false,
          'waterplay': false,
          'duckpond': false,
          'sandpit': false,
        },
        this.user = const {
          'visited': false,
          'favourite': false,
        },
        this.distance = 0.0,
        this.flare = const {
          'asset': '',
          'size': 150.0,
          'running_animation': '',
          'animation_ontap': '',
          'top': 100.0,
          'left': 100.0,
          'on_screen': false,
          'scale': 1.0
        }});
}

List<Playground> playgrounds = [
  Playground(
      id: '0',
      playground: false,
      location: '',
      name: 'Download the app',
      secretCode: '',
      flare: {
        'asset': 'assets/swing_character.flr',
        'running_animation': 'Swing',
        'size': 150.0
      }),
  Playground(
      id: '1',
      location: '',
      playground: false,
      name: 'Visit a playground with a duckpond',
      secretCode: '',
      flare: {
        'asset': 'assets/Duckpond.flr',
        'running_animation': 'Untitled',
        'size': 200.0
      }),

  Playground(
      id: '2',
      playground: false,
      location: '',
      name: 'Early Bird: visit a playground before 9am',
      secretCode: '',
      flare: {
        'asset': 'assets/robin.flr',
        'animation_ontap': 'Untitled',
        'size': 150.0
      }),
  Playground(
      id: '3',
      playground: false,
      location: '',
      name: 'Night Owl: visit a playground after 5pm',
      secretCode: '',
      flare: {
        'asset': 'assets/owl.flr',
        'animation_ontap': 'Untitled',
        'size': 150.0
      }),
  Playground(
      id: '4',
      playground: false,
      location: '',
      name: '20 playgrounds visited!',
      secretCode: '',
      flare: {
        'asset': 'assets/bench.flr',
        'running_animation': 'Untitled',
        'size': 150.0
      }),
  Playground(
      id: '5',
      playground: false,
      location: '',
      name: 'Visit a playground with a cafe!',
      secretCode: '',
      flare: {
        'asset': 'assets/cafe.flr',
        'running_animation': 'Untitled',
        'animation_ontap': 'licking',
        'size': 150.0
      }),
  Playground(
      id: '6',
      playground: false,
      location: '',
      name: 'Visit a playground with a sandpit',
      secretCode: '',
      flare: {
        'asset': 'assets/sandpit.flr',
        'running_animation': 'Untitled',
        'size': 150.0
      }),
  Playground(
    id: '7',
    playground: true,
    name: 'Blaise Castle',
    location: "Henbury",
    secretCode: '775-867',
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
      'size': 150.0,
      'asset': 'assets/blaise_castle.flr',
      'running_animation': 'flag',
      'animation_ontap': 'sliding',
    },
  ),
  Playground(
    id: '8',
    playground: true,
    name: 'Cotham Gardens',
    location: 'Cotham',
    secretCode: '543-294',
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
      'size': 150.0,
      'asset': 'assets/cotham_gardens.flr',
      'running_animation': 'Untitled'
    },
  ),

  Playground(
    id: '9',
    location: 'Clifton',
    playground: true,
    name: 'Clifton',
    secretCode: '335-642',
    description:
    'This shady playground very near the suspension bridge has two wooden climbing frames, monkey bars, trampolines, '
        'extra-tall swings. It is surrounded by rocks and trees for children to explore.',
    address: ' Clifton, Bristol BS8 3LX',
    coordinates: LatLng(51.456544, -2.624860),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/clifton.flr',
      'animation_ontap': 'Untitled'
    },
  ),

  Playground(
    id: '10',
    name: 'Felix Road',
    playground: true,
    location: 'Easton',
    secretCode: '261-012',
    description:
    'This is a fantastic adventure playground which means that this play area is always supervised by trained qualified playworkers and you will need to check the opening times before you go. Adventure playgrounds are designed for children over the age of 8 but younger children are welcome with an adult. The ethos is very much one of learning to take risks. This adventure playground has a huge castle structure as well as well as plenty of other equipment for all ages and abilities including musical stepping stones. There are usually play sessions running which can be anything from cycling to baking. They also offer extremely reasonable food. ',
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
      'size': 150.0,
      'asset': 'assets/felix_road.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '11',
    name: 'Greville Smyth',
    playground: true,
    location: 'Ashton Gate',
    secretCode: '493-697',
    description:
    'This lovely park has a great range of equipment for all ages. It is set in a large flat park, ideal for learning to cycle or scoot. It features a large climbing frame with monkey bars, swings, a roundabout and some excellent spinning equipment for older children. ',
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
    secretCode: '935-809',
    description:
    'This enormous playground definitely has something for everyone. It has pretty much any piece of equipment you can think of including zipwire, sandpit, all sorts of climbing frames. It has a cafe and there is water play. It even has a skate park.',
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
      'size': 200.0,
      'asset': 'assets/hengrove.flr',
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
    id: '13',
    name: 'Golden Hill',
    playground: true,
    location: 'Horfield',
    secretCode: '228-645',
    description:
    'This smallish but lovely playground has a great range of equipment for all abilities including a nexus for older children, climbing frame and swings. There is a cafe with a toilet nearby. ',
    address: 'Kellaway Ave, Westbury Park, Bristol BS6 7YQ',
    coordinates: LatLng(51.485344, -2.594317),
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
    },
  ),
  Playground(
    id: '14',
    name: 'Kings Head Lane',
    playground: true,
    location: 'Bedminster Down',
    secretCode: '278-692',
    description:
    'This lovely playground is especially suited to children who like to spin! It features a pirate ship, sandpit, rocker, tyre swing and basket swing and is set in a beautiful Victorian park.',
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
    secretCode: '221-911',
    description:
    'This is a lovely playground by the river, great for boat enthusiasts and for escaping the city. It features several wooden climbing structures and a roundabout.',
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
    },
  ),
  Playground(
    id: '16',
    name: 'Oldbury Court Estate',
    location: 'Fishponds',
    playground: true,
    secretCode: '898-948',
    description:
    'This huge playground set in the beautiful Oldbury Court Estate has something for everyone. It includes a large pirate ship climbing frame, sand pit, roundabout, water play, exercise machines. It also has a cafe and toilets.',
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
      'size': 150.0,
      'asset': 'assets/oldbury_court_estate.flr',
      'animation_ontap': 'Untitled',
      'running_animation': 'running_animation'
    },
  ),
  Playground(
    id: '17',
    name: 'Redcatch Park',
    playground: true,
    location: 'Knowle',
    secretCode: '402-759',
    description:
    'Set in a lovely Victorian park this playground has plenty of equipment for all ages. It includes a trampoline, climbing frame with monkey bars, roundabout and maze. It has lots of picnic tables around and a cheap and cheerful cafe. ',
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
      'size': 150.0,
      'asset': 'assets/redcatch.flr',
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
    id: '18',
    name: 'Southmead Adventure Playground',
    playground: true,
    location: 'Southmead',
    secretCode: '575-287',
    description:
    'This is a fantastic adventure playground which means that this play area is always supervised by trained qualified playworkers and you will need to check the opening times before you go. Adventure playgrounds are designed for children over the age of 8 but younger children are welcome with an adult. The ethos is very much one of learning to take risks. This adventure playground has a huge boat structure as well as well as plenty of other equipment for all ages and abilities including water play, a castle, musical play. There are usually play sessions running which can be anything from cycling to baking. They also offer extremely reasonable food.',
    address: 'Doncaster Rd, Bristol BS10 5PP',
    coordinates: LatLng(51.499395, -2.603408),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': true,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/southmead.flr',
      'running_animation': 'Untitled',
    },
  ),
  Playground(
    id: '19',
    name: 'St Andrews',
    location: 'St Andrews',
    secretCode: '403-612',
    playground: true,
    description:
    'This beautiful park has a small paddling pool which is a huge attraction on a sunny day. It also has a great play area with a sandpit with a digger, obstacle courses and climbing frames. There is a lovely cafe kiosk with outdoor seating area and there are public toilets. ',
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
      'size': 150.0,
      'asset': 'assets/st_andrews.flr',
      'running_animation': 'Untitled',
    },
  ),
  Playground(
    id: '20',
    name: 'St George',
    location: 'St George',
    playground: true,
    secretCode: '152-565',
    description:
    'This play area was designed to look like a dragon and has a great range of equipment for all ages. There is a sandpit, climbing structure tunnel slides and a seesaw. You can also find a large skate park, a duckpond and a cafe kiosk here so there is definitely something for everyone.',
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

  Playground(
    id: '21',
    name: 'Arnos Court Park',
    playground: true,
    location: 'Brislington',
    secretCode: '887-188',
    description:
    'Set in the beautiful Arnos Court, this playground has an attractive copse of trees in the middle. It has a zipwire, sandpit, slide, roundabout and basket swing. There is also a bmx track nearby.',
    address: '2 Hampstead Rd, Brislington, Bristol BS4 3HJ',
    coordinates: LatLng(51.440360, -2.560493),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/arnos_court.flr',
      'running_animation': 'Untitled',
    },
  ),
  Playground(
    id: '22',
    playground: true,
    name: 'Brandon Hill',
    location: 'Clifton',
    secretCode: '182-154',
    description:
    'Set on the stunning Brandon Hill full of gorgeous mature trees with views of Cabot Tower this is a lovely play area with equipment for all ages. There is a fenced dog-free area with a toddler swing and climbing frame within a large sand pit. Outside the sand pit is another play area more suitable for older children. There is climbing frame, swings and a crow’s nest. Other facilities in this park are the toilets which are located close to Cabot Tower. The park is very hilly and therefore may be challenging for people with disabilities and for wheelchair users.',
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
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '23',
    name: 'Avonmouth',
    location: 'Avonmouth',
    playground: true,
    secretCode: '922-271',
    address: 'St Andrew\'s Rd, Bristol BS11 9EL',
    description:
    'This is a lovely little playground in Avonmouth with a great variety of equipment. It features a small obstacle course, climbing frame and rocking motorbike.',
    coordinates: LatLng(51.500495, -2.697677),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/avonmouth.flr',
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '24',
    name: 'Victoria Park',
    location: 'Bedminster',
    playground: true,
    secretCode: '638-659',
    description:
    'This beautiful park has two playgrounds to discover with plenty to suit all ages including mini trampolines, a high ropes obstacle  course and a wide slide. There is a cafe kiosk which does lovely cakes and ice creams (check opening hours)',
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
    id: '25',
    name: 'Salthouse Fields',
    playground: true,
    location: 'Clevedon',
    secretCode: '601-152',
    description:
    'Clevedon is well worth a day trip. This playground features a sandpit, swings, obstacle course, climbing frame and roundabout. You can also catch the miniature train nearby or explore the marine lake. ',
    address: 'Salthouse Rd, Clevedon BS21 7TR',
    coordinates: LatLng(51.434703, -2.868830),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': true,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/clevedon.flr',
      'running_animation': 'Untitled',
    },
  ),
  Playground(
    id: '26',
    name: 'Pittville Park',
    location: 'Cheltenham',
    playground: true,
    secretCode: '175-508',
    description:
    'This stunning park is well worth the trip. It is set in a beautiful park with a lovely boating lake where you can hire rowing boats. It has a huge main play area with all the equipment you could ask for as well as other bits of play equipment dotted around the park. There is even an Aviary.',
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
    id: '27',
    name: 'Mundy Playing Fields',
    location: 'Thornbury',
    playground: true,
    secretCode: '509-159',
    description:
    'This lovely park is brilliant for a sunny day with a splash pad as well as a stream to paddle in and build damns. '
        'It also has lots of great play equipment including swings, slides, climbing frames. It also has adult exercise equipment and some lovely wooden sculptures. ',
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
      'size': 150.0,
      'animation_ontap': 'Untitled'
    },
  ),
  Playground(
    id: '28',
    playground: true,
    name: 'Royal Victoria',
    location: 'Bath',
    secretCode: '766-672',
    description:
    'This enormous playground is fantastic for all ages. It has almost every piece of equipment you could dream of. Well worth the journey to beautiful Bath.',
    address: 'Bath BA1 2LZ',
    coordinates: LatLng(51.385797, -2.376246),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': true,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/royal_victoria_bath.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '29',
    name: 'Kingsgate Park',
    playground: true,
    location: 'Yate',
    secretCode: '018-646',
    description:
    'This playground has everything you can ask for with play equipment for all ages including a high ropes course, a duckpond, water play and sand pit.',
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
    },
  ),
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
    id: '30',
    name: 'Monks Park',
    playground: true,
    location: 'Southmead',
    secretCode: '963-514',
    description:
    'This small play area is great for any airplane enthusiasts. It was sponsored by airbus and has an aeronautical theme! ',
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
    },
  ),
  Playground(
    id: '31',
    name: 'Page Park',
    playground: true,
    location: 'Stapleton',
    secretCode: '564-759',
    description:
    'This beautiful park has lots for everyone including a lovely cafe, 3 different play areas to cater for all tastes, a beautiful sensory garden, an aviary and very well tended gardens. ',
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
    id: '32',
    name: 'Elm Park',
    playground: true,
    location: 'Filton',
    secretCode: '266-281',
    description:
    'This playground by Filton Leisure centre has plenty of great equipment including a mini trampoline, two large climbing frames, '
        'roundabouts, swings, zip wire. There is a toilet in the leisure centre and a small cafe stand.',
    address: 'Elm Park, Filton, Bristol BS34 7PS',
    coordinates: LatLng(51.506859, -2.573659),
    features: {
      'cafe': true,
      'toilet': true,
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
    id: '33',
    name: 'Gainsborough Square',
    playground: true,
    secretCode: '449-349',
    location: 'Lockleaze',
    description:
    'This playground has a nice range of equipment including a rope swing, climbing frame, swings, slide and spinner bowl. ',
    address: 'Gainsborough Square, Lockleaze, Bristol BS7 9XA',
    coordinates: LatLng(51.490299, -2.563094),
    features: {
      'cafe': false,
      'toilet': false,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/gainsborough_square.flr',
      'size': 150.0,
      'running_animation': 'Untitled'
    },
  ),
  Playground(
    id: '34',
    playground: true,
    name: 'Perret\'s Park',
    location: 'Totterdown',
    secretCode: '676-187',
    description:
    'This is one of the newer playgrounds. It is themed around hot air balloons celebrating the fact that the sloping park is a wonderful place to watch the balloons going up from Ashton Court. It has some great equipment including a large roundabout, a nexus climbing frame, some stepping stones and a slide.',
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
      id: '35',
      name: 'Victoria Park Cardiff',
      location: 'Cardiff',
      playground: true,
      secretCode: '666-722',
      description:
      'This park is well worth the journey on a sunny day as it has an incredible splash pad. It also has a great range of equipment including a nexus for older children, swings, climbing frame, obstacle course. It is set in a beautiful Victorian park.',
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
      id: '36',
      name: 'Stoke Lodge',
      location: 'Stoke Bishop',
      playground: true,
      secretCode: '776-470',
      description:
      'This is a fairly new and well maintained park with some lovely equipment. It has a series of little man made hills which are great fun for climbing up and down. It also features a hammock, zip wire, several climbing frames and a beautiful carved bench.',
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
      id: '37',
      name: 'Victory  Park',
      location: 'Brislington  ',
      playground: true,
      secretCode: '005-495',
      description:
      'This smallish park has some really nice equipment including a see-saw, a digger, an obstacle course and some great climbing equipment.',
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
    id: '38',
    name: 'Canford Park',
    playground: true,
    location: 'Westbury-On-Trym',
    secretCode: '094-989',
    description:
    'Set in the lovely Canford park, this play area has a great range of equipment for all ages including a helicopter climbing frame, '
        'a nexus for older children, roundabouts, a sandpit, slide, swings and a tight rope. The park is lovely and flat and therefore great for learning to cycle or roller skate. There are toilets and a cafe kiosk.',
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
    id: '39',
    playground: true,
    name: 'Lake Grounds',
    location: 'Portishead',
    secretCode: '803-585',
    description:
    'Portishead Lake Grounds has plenty to keep all ages occupied . As well as a lovely play area featuring a climbing frame, swings and even adult exercise equipment, you can take a walk around the lake and feed the ducks (no bread please!) or even hire a pedalo. There\'s a cafe for refreshments as well as a toilet.',
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
    id: '40',
    playground: true,
    name: 'Netham Park',
    location: 'Redfield',
    secretCode: '883-989',
    description:
    'Netham Park has two lovely play areas for different ages and includes a large net climbing cone and slide, roundabout, rocker, Rocker seesaw, rope bridge,  toddler slide, nest seat swing, climbing pole, slingshot, witches hat and an outdoor table tennis table. The play area has been landscaped with grass mounds, boulders. Accessible toilets are available in the Pavilion.',
    address: 'Hill Avenue, Bedminster, BS3 4SN',
    coordinates: LatLng(51.455151, -2.557324),
    features: {
      'cafe': false,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': true,
    },
    flare: {
      'asset': 'assets/netham.flr',
      'animation_ontap': 'sliding',
      'running_animation': 'blinking',
      'size': 150.0
    },
  ),
  Playground(
    id: '41',
    playground: true,
    name: 'Redland Green',
    location: 'Redland',
    secretCode: '607-868',
    description:
    'Set in the middle of this lovely green space this small playground has a lovely sandpit, witches hat, swings, zipwire and rocking elephants.',
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
      'size': 150.0,
      'asset': 'assets/redland_green.flr',
      'running_animation': 'Untitled',
      'animation_ontap': '',
    },
  ),
  Playground(
    id: '42',
    name: 'The Vench',
    secretCode: '792-488',
    playground: true,
    location: 'Lockleaze',
    description:
    'This is a fantastic adventure playground which means that this play area is always supervised by trained qualified playworkers and you will need to check the opening times before you go. Adventure playgrounds are designed for children over the age of 8 but younger children are welcome with an adult. The ethos is very much one of learning to take risks. This adventure playground features an obstacle course, a drop slide, a zipwire, tunnels, trampoline as well as well as plenty of other equipment for all ages and abilities. There are usually play sessions running which can be anything from cycling to baking. They also offer extremely reasonable food.',
    address: 'Romney Ave, Lockleaze, Bristol BS7 9TB',
    coordinates: LatLng(51.493187, -2.559953),
    features: {
      'cafe': true,
      'toilet': true,
      'waterplay': false,
      'duckpond': false,
      'sandpit': false,
    },
    flare: {
      'size': 150.0,
      'asset': 'assets/the_vench.flr',
      'running_animation': 'Untitled',
    },
  ),
  Playground(
    id: '43',
    name: 'Mowbray Park',
    location: 'Stockwood',
    secretCode: '458-088',
    playground: true,
    description:
    'This is a small but perfectly formed playground with lots of quirky features such as moles coming out of the ground and interesting bins. There is an obstacle course with two bridges as well as a swing roundabout and rockers.',
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
    id: '44',
    name: 'Troopers Hill',
    location: 'St George',
    playground: true,
    secretCode: '544-939',
    description:
    'This is one of the newest playgrounds with some fantastic equipment. It is set in the Troopers Hill Nature Reserve and it is well worth a stroll to the top to see the chimney and the lovely views of the city. '
        'The playground features and obstacle course, roundabout, train and swings.',
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
    },
  ),
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
  GeolocationStatus geolocationStatus =
  await Geolocator().checkGeolocationPermissionStatus();

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

      if (playgrounds[i].distance < 0.2) {
        return i;
      }
    }
  }

  return null;
}

int countNumberOfPrizes() {
  int _numberOfPrizesWon = 0;
  for (int i = 0; i < playgrounds.length; i++) {
    if (playgrounds[i].user['visited']) {
      _numberOfPrizesWon++;
    }
  }
  return _numberOfPrizesWon;
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
              ''').then((value) {
      for (int i = 0; i < playgrounds.length; i++) {
        insert(i, db);
      }
    });

  }

  // Database helper methods:

  Future<int> insert(int i, Database db) async {

    int id =
    await db.insert('playgrounds', {'id': playgrounds[i].id, 'visited': 0, 'favourite': 0});

    return id;
  }

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
    return maps;
  }

  getUserDb() async {

    Database db = await database;

    List<Map> map = await queryAllPlaygrounds().then((map){

      for (int i = 0; i < playgrounds.length; i++) {
        playgrounds.replaceRange(i, i + 1, [
          Playground(
            id: playgrounds[i].id,
            name: playgrounds[i].name,
            playground: playgrounds[i].playground,
            location: playgrounds[i].location,
            secretCode: playgrounds[i].secretCode,
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
      }return map;
    });





  }

  deleteDB() async {
    Database db = await database;
    db.delete('playgrounds');


  }

  updateGameLocation(
      int i, double left, double top, double scale, bool on_screen) async {
    playgrounds.replaceRange(i, i + 1, [
      Playground(
          id: playgrounds[i].id,
          name: playgrounds[i].name,
          playground: playgrounds[i].playground,
          location: playgrounds[i].location,
          secretCode: playgrounds[i].secretCode,
          description: playgrounds[i].description,
          address: playgrounds[i].address,
          coordinates: playgrounds[i].coordinates,
          features: playgrounds[i].features,
          distance: playgrounds[i].distance,
          flare: {
            'asset': playgrounds[i].flare['asset'],
            'size': playgrounds[i].flare['size'],
            'running_animation': playgrounds[i].flare['running_animation'],
            'animation_ontap': playgrounds[i].flare['animation_ontap'],
            'top': top,
            'left': left,
            'on_screen': on_screen,
            'scale': scale
          },
          user: playgrounds[i].user)
    ]);
  }

  updateFavouritesOrVisited(int i, bool favourite) async {
    playgrounds.replaceRange(i, i + 1, [
      Playground(
          id: playgrounds[i].id,
          name: playgrounds[i].name,
          playground: playgrounds[i].playground,
          location: playgrounds[i].location,
          secretCode: playgrounds[i].secretCode,
          description: playgrounds[i].description,
          address: playgrounds[i].address,
          coordinates: playgrounds[i].coordinates,
          features: playgrounds[i].features,
          flare: playgrounds[i].flare,
          distance: playgrounds[i].distance,
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

