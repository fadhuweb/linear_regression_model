const List<String> countryOptions = [
  "Angola", "Benin", "Burkina Faso", "Burundi", "Cameroon", "Central African Republic", "Chad", "DRC",
  "Ethiopia", "Ghana", "Kenya", "Lesotho", "Liberia", "Madagascar", "Malawi", "Mali", "Mauritania",
  "Mozambique", "Niger", "Nigeria", "Rwanda", "Senegal", "Sierra Leone", "Somalia", "South Africa",
  "South Sudan", "Sudan", "Tanzania, United Republic of", "Togo", "Uganda", "Zambia", "Zimbabwe"
];

const List<String> admin1Options = [
  "Abia", "Adamawa", "Adrar", "Afar", "Agadez", "Ahafo", "Akwa Ibom", "Alibori", "Amhara", "Anambra",
  "Antananarivo", "Antsiranana", "Arusha", "Ashanti", "Assaba", "Atacora", "Atlantique", "Bakool", "Bamako", "Bamingui-Bangoran",
  "Barh el Gazel", "Baringo", "Bas-Uele", "Basse-Kotto", "Batha", "Bauchi", "Bay", "Bayelsa", "Bengo", "Benguela",
  "Benishangul Gumuz", "Benue", "Berea", "Bie", "Blue Nile", "Bomet", "Bomi", "Bong", "Bono", "Bono East",
  "Borgou", "Borno", "Boucle du Mouhoun", "Brakna", "Bubanza", "Bujumbura Rural", "Bungoma", "Bururi", "Busia", "Butha-Buthe",
  "Cabinda", "Cabo Delgado", "Cankuzo", "Cascades", "Central", "Central Darfur", "Central Equatoria", "Centrale", "Centre", "Centre-Est",
  "Centre-Nord", "Centre-Ouest", "Centre-Sud", "Chari-Baguirmi", "Cibitoke", "Collines", "Copperbelt", "Couffo", "Cross River", "Cunene",
  "Dakar", "Dar es Salaam", "Delta", "Diffa", "Diourbel", "Dire Dawa", "Dodoma", "Donga", "Dosso", "East",
  "East Darfur", "Eastern", "Eastern Cape", "Eastern Equatoria", "Ebonyi", "Edo", "Ekiti", "Elgeyo-Marakwet", "Embu", "Enugu",
  "Equateur", "Est", "Far North", "Fatick", "Federal Capital Territory", "Fianarantsoa", "Free State", "Galgaduud", "Gambela", "Gao",
  "Garissa", "Gauteng", "Gaza", "Gbarpolu", "Gedaref", "Gedo", "Geita", "Gezira", "Gitega", "Gombe",
  "Gorgol", "Grand Bassa", "Grand Cape Mount", "Grand Gedeh", "Grand Kru", "Greater Accra", "Guera", "Guidimaka", "Hadjer-Lamis", "Harari",
  "Haut-Katanga", "Haut-Lomami", "Haut-Mbomou", "Haut-Uele", "Haute-Kotto", "Hauts-Bassins", "Hiiraan", "Hodh ech Chargui", "Hodh el Gharbi", "Homa Bay",
  "Huambo", "Huila", "Imo", "Inchiri", "Inhambane", "Iringa", "Isiolo", "Jigawa", "Jonglei", "Kaduna",
  "Kaffrine", "Kagera", "Kajiado", "Kakamega", "Kanem", "Kano", "Kaolack", "Kara", "Karuzi", "Kasai",
  "Kasai-Central", "Kassala", "Katavi", "Katsina", "Kayanza", "Kayes", "Kebbi", "Kedougou", "Kemo", "Kericho",
  "Khartoum", "Kiambu", "Kidal", "Kigali", "Kigoma", "Kilifi", "Kilimanjaro", "Kirinyaga", "Kirundo", "Kisii",
  "Kisumu", "Kitui", "Kogi", "Kolda", "Kongo-Central", "Koulikoro", "Kuando Kubango", "Kuanza Norte", "Kuanza Sul", "Kwale",
  "Kwango", "Kwara", "Kwazulu-Natal", "Kwilu", "Lac", "Lagos", "Laikipia", "Lakes", "Lamu", "Leribe",
  "Limpopo", "Lindi", "Littoral", "Lobaye", "Lofa", "Logone Occidental", "Logone Oriental", "Lomami", "Louga", "Lower Juba",
  "Lower Shabelle", "Lualaba", "Luanda", "Luapula", "Lunda Norte", "Lunda Sul", "Lusaka", "Machakos", "Mafeteng", "Mahajanga",
  "Mai-Ndombe", "Makamba", "Makueni", "Malanje", "Mambere-Kadei", "Mandera", "Mandoul", "Manica", "Manicaland", "Maniema",
  "Manyara", "Maputo", "Mara", "Maradi", "Margibi", "Maritime", "Marsabit", "Maryland", "Maseru", "Mashonaland Central",
  "Mashonaland East", "Mashonaland West", "Masvingo", "Matabeleland North", "Matabeleland South", "Matam", "Mayo-Kebbi Est", "Mayo-Kebbi Ouest", "Mbeya", "Mbomou",
  "Meru", "Middle Juba", "Middle Shabelle", "Midlands", "Migori", "Mohale's Hoek", "Mokhotlong", "Mombasa", "Mono", "Montserrado",
  "Mopti", "Morogoro", "Moxico", "Moyen-Chari", "Mpumalanga", "Mtwara", "Muchinga", "Mudug", "Muramvya", "Murang'a",
  "Muyinga", "Mwanza", "Mwaro", "Nairobi", "Nakuru", "Namibe", "Nampula", "Nana-Grebizi", "Nana-Mambere", "Nandi",
  "Narok", "Nasarawa", "Ngozi", "Niassa", "Niger", "Nimba", "Njombe", "Nord", "North", "North Darfur",
  "North East", "North Kivu", "North Kordofan", "North Ubangi", "North West", "North-Western", "Northern", "Northern Bahr el Ghazal", "Northern Cape", "Northwest",
  "Nyamira", "Nyandarua", "Nyeri", "Ogun", "Ombella-Mpoko", "Ondo", "Oromia", "Osun", "Oti", "Ouaddai",
  "Ouaka", "Ouham", "Ouham-Pende", "Ouémé", "Oyo", "Pemba North", "Pemba South", "Plateau", "Plateau-Central", "Plateaux",
  "Pwani", "Qacha's Nek", "Quthing", "Red Sea", "River Gee", "River Nile", "Rivercess", "Rivers", "Rukwa", "Rutana",
  "Ruvuma", "Ruyigi", "SNNPR", "Sahel", "Saint-Louis", "Salamat", "Samburu", "Sangha-Mbaere", "Sankuru", "Savanes",
  "Savannah", "Sedhiou", "Segou", "Shinyanga", "Siaya", "Sikasso", "Sila", "Simiyu", "Singida", "Sinnar",
  "Sinoe", "Sofala", "Sokoto", "Somali", "South", "South Darfur", "South Kivu", "South Kordofan", "South Ubangi", "Southern",
  "Southwest", "Sud-Ouest", "Tabora", "Tagant", "Tahoua", "Taita Taveta", "Tambacounda", "Tana River", "Tandjile", "Tanga",
  "Tanganyika", "Taraba", "Tete", "Thaba-Tseka", "Tharaka Nithi", "Thies", "Tigray", "Tillaberi", "Toamasina", "Togdheer",
  "Toliara", "Tombouctou", "Trans Nzoia", "Trarza", "Tshopo", "Turkana", "Uasin Gishu", "Uige", "Unity", "Upper East",
  "Upper Nile", "Upper West", "Vakaga", "Vihiga", "Volta", "Wadi Fira", "Wajir", "Warrap", "West", "West Darfur",
  "West Kordofan", "West Pokot", "Western", "Western Bahr el Ghazal", "Western Cape", "Western Equatoria", "Western North", "White Nile", "Woqooyi Galbeed", "Yobe",
  "Zaire", "Zambezia", "Zamfara", "Zanzibar Central/South", "Zanzibar North", "Zanzibar Urban/West", "Ziguinchor", "Zinder", "Zou"
];

const List<String> productOptions = [
  'Avocado', 'Bambara groundnut', 'Banana', 'Barley', 'Bean (Hyacinth)', 'Beans (Rosecoco)', 'Beans (White)', 'Beans (mixed)', 'Beet', 'Bush Bean', 'Cabbage', 'Canola Seed', 'Capsicum Chinense', 'Carrots', 'Cashew (unshelled)', 'Cassava', 'Celery', 'Cereal Crops', 'Chick Peas', 'Chili Pepper', 'Coffee', 'Coriander', 'Cotton', 'Cotton (Acala)', 'Cotton (American)', 'Cottonseed', 'Cowpea', 'Cucumber', 'Eggplant', 'Ethiopian Cabbage', 'Fava Bean', 'Fenugreek', 'Field Peas', 'Fonio', 'Garlic', 'Geocarpa groundnut', 'Ginger', 'Goussi', 'Green Bean', 'Green Pea', 'Green Peppers', 'Groundnuts (In Shell)', 'Hops', 'Jute', 'Kale', 'Lemon', 'Lentils', 'Lettuce', 'Linseed', 'Macadamia', 'Maize', 'Maize (Yellow)', 'Mango', 'Melon', 'Millet', 'Molokhia', 'Mung bean', 'Neug', 'Oats', 'Okras', 'Onions', 'Orange', 'Pam Nut', 'Papaya', 'Paprika', 'Pea', 'Pepper', 'Pigeon Pea', 'Pineapple', 'Pole Bean', 'Potato', 'Pyrethrum', 'Rape', 'Rice', 'Sesame Seed', 'Sorghum', 'Sorghum (Red)', 'Sorrel', 'Soybean', 'Squash', 'Squash and Melon Seeds', 'Sugarcane', 'Sunflower Seed', 'Sweet Potatoes', 'Taro', 'Tea', 'Teff', 'Tobacco', 'Tomato', 'Velvet Bean', 'Virginia Peanut', 'Watermelon', 'Wheat', 'Yams'
  ];

const List<String> seasonOptions = [
  '1st Season', '2nd Season', 'Annual', 'Bas-fond', 'Cold off-season', 'Cold-off', 'Cotton season', 'Dam retention', 'Decrue controlee', 'Deyr', 'Deyr-off', 'Dry', 'First', 'Gu', 'Gu-off', 'Hot off-season', 'Long', 'Long/Dry', 'Main', 'Main-off', 'Meher', 'North 1st Season', 'North 2nd Season', 'Rice season', 'Season A', 'Season B', 'Season C', 'Second', 'Short', 'Summer', 'Walo', 'Wet', 'Winter'
];

const List<String> systemOptions = [
  "A1 (PS)", "A2 (PS)", "All (PS)", "Bas-fonds rainfed (PS)", "CA (PS)", "Commercial (PS)", "Communal (PS)",
  "LSCF (PS)", "Mechanized (PS)", "OR (PS)", "Plaine/Bas-fond irrigated (PS)", "Rainfed (PS)", "SSCF (PS)",
  "Semi-Mechanized (PS)", "Small_and_medium_scale", "agro_pastoral", "dam irrigation", "dieri", "irrigated",
  "large_scale", "mechanized_rainfed", "none", "parastatal recessional", "recessional (PS)", "riverine",
  "surface water", "traditional_rainfed"
];

const List<String> monthOptions = [
  '1 - January',
  '2 - February',
  '3 - March',
  '4 - April',
  '5 - May',
  '6 - June',
  '7 - July',
  '8 - August',
  '9 - September',
  '10 - October',
  '11 - November',
  '12 - December',
];