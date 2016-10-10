-- nc, sc, nv, caravan, rivet, 

tradeItems = {

	["Шашлык из белки"] = { weight = 0.1, d = "Еда. Здоровье +5; Радиация +5; Голод -5; Вес 0.1 кг", prices = { nc_food = 10, sc_food = 100, nv_food = 70, ehl_food = 50, motel_food = 90, fatsy = 80, sayag = 60, }, item_id = 2, quant = 1},
	["Шашлык из игуаны"] = { weight = 0.2, d = "Еда. Здоровье +5; Радиация +10; Голод -10; Вес 0.2 кг", prices = { nc_food = 20, sc_food = 110, nv_food = 80, ehl_food = 20, motel_food = 40, west_car = 170, perkins = 160, fatsy = 100, sayag = 80 }, item_id = 3, quant = 1}, 
	["Радотаракан"] = { weight = 0.2, d = "Еда. Здоровье +30; Радиация +30; Голод -25; Вес 0.2 кг", prices = { nc_food = 100, sc_food = 140, ehl_food = 40, fatsy = 130, sayag = 110 }, item_id = 4, quant = 1},
	["Чистая вода"] = { weight = 0.5, d = "Еда. Здоровье +40; Радиация -20; Голод -1; Вес 0.5", prices = { nc_food = 80, sc_food = 200, nv_food = 35, motel_food = 100, megatonna = 45, caravan_food = 70, west_car = 110, perkins = 100, preston = 35, bonny = 40, sayag = 35,  }, item_id = 5, quant = 1},
	["Зараженная вода"] = { weight = 0.5, d = "Еда. Здоровье +30; Радиация +20; Вес 0.5", prices = { ehl_food = 9, motel_food = 8, caravan_food = 13 }, item_id = 22, quant = 1},
	["Рука гуля"] = { weight = 2, d = "Еда. Здоровье +30; Радиация +30; Голод -30; Вес 2 кг", prices = { nc_food = 50, sc_food = 90, nv_food = 50, motel_food = 80, caravan_food = 70, fatsy = 90,  }, item_id = 10, quant = 1},
	["Рука гуля x5"] = { weight = 2, d = "Еда. Здоровье +50; Радиация +30; Голод -30; Вес 10 кг", prices = { nv_food = 200, motel_food = 320 }, item_id = 10, quant = 5 },
		
	["Виски"] = { weight = 0.5, d = "Алкоголь. Здоровье +10; Радиация -10; Голод -5; Вес 0.5 кг.", prices = { megatonna = 40, caravan_food = 35, west_car = 25, perkins = 25, bonny = 35, sayag = 40, }, item_id = 11, quant = 1},
	["Водка"] = { weight = 0.5, d = "Алкоголь. Здоровье +20; Радиация -20; Голод -2; Вес 0.5 кг.", prices = { megatonna = 60, caravan_food = 50,  bonny = 55, sayag = 70 }, item_id = 12, quant = 1},
	["Самогон"] = { weight = 1, d =  "Алкоголь. Здоровье -5; Радиация -20; Голод -7; Вес 1 кг", prices = { megatonna = 30, caravan_food = 20, preston = 35,  bonny = 30, sayag = 25 }, item_id = 13, quant = 1},
	["Тушенка"] = { weight = 0.2, d =  "Еда. Полностью убирает голод. Вес 0.2 кг", prices = { caravan_food = 200, west_car = 400, fatsy = 150, }, item_id = 18, quant = 1},
	["Тушенка x100"] = { weight = 0.2, d =  "Еда. Полностью убирает голод. Вес 20 кг", prices = { caravan_food = 18000 }, item_id = 18, quant = 100},
	["Консервы"] = { weight = 0.2, d =  "Еда. Голод -20; Вес 0.2 кг", prices = { caravan_food = 30, west_car = 90, fatsy = 80 }, item_id = 19, quant = 1},
	["Пакетик орехов"] = { weight = 0.1, d = "Еда. Голод -3; Вес 0.1 кг", prices = { caravan_food = 5, fatsy = 10, bonny = 8, sayag = 10 }, item_id = 20, quant = 1},
		
	["Винт"] = { weight = 1, d = "Лекарство. ОД +10; Голод +10; Вес 1 кг.", prices = { nc_medic = 300, sc_medic = 80, nv_medic = 350, ehl_medic = 350, motel_medic = 400, caravan_medic = 60, preston = 90, }, item_id = 6, quant = 1, },
	["Антирад"] = { weight = 1, d = "Лекарство. Полностью выводит радиацию из организма. Голод +10; Вес 1 кг.", prices = { nc_medic = 700, sc_medic = 300, nv_medic = 550, ehl_medic = 700, motel_medic = 570, caravan_medic = 290, west_car = 300, perkins = 270, preston = 250, }, item_id = 7, quant = 1 },
	["Стимулятор"] = { weight = 0.2, d = "Лекарство. Полностью восстанавливает здоровье. Голод +5; Вес 0.2 кг.", prices = { nc_medic = 650, sc_medic = 400, nv_medic = 500, ehl_medic = 700, motel_medic = 550, caravan_medic = 250, preston = 300, }, item_id = 1, quant = 1 },
	["АнтиРад костюм"] = { weight = 10, d = "Защита от внешней радиации. Вес 10 кг", prices = { sc_medic = 8000, caravan_medic = 5000, }, item_id = 14, quant = 1 },

	["Кислородный накопитель"] = { weight = 0.5, d = "Позволяет пополнять запас воздуха под водой. Вес 0.5 кг.", prices = { caravan_medic = 100 }, item_id = 109, quant = 1},
	
	["Скотч"] = { weight = 0.5, d = "Хлам. Вес 0.5 кг.", prices = { gorbov = 20 }, item_id = 95, quant = 1},
	["Ткани"] = { weight = 2, d = "Хлам. Вес 2 кг.", prices = { gorbov = 100 }, item_id = 72, quant = 1},
	["Нитки и иголка"] = { weight = 0.1, d = "Хлам. Вес 0.1 кг.", prices = { gorbov = 30 }, item_id = 73, quant = 1},
	["Капсюль"] = { weight = 0.0001, d = "Хлам. Вес 0.0001 кг.", prices = { gorbov = 2 }, item_id = 71, quant = 1},
	["Порох"] = { weight = 0.001, d = "Хлам. Вес 0.001 кг.", prices = { gorbov = 5 }, item_id = 70, quant = 1},
		
	["Китайский автомат"] = { weight = 7, d = "УВС: 132. Вес 7 кг.", prices = { bullet = 20000, nc_weap = 30000, sc_weap = 40000, nv_weap = 25000, caravan_weap = 18000, klamat_weap = 25000, }, item_id = 24, quant = 1},
	["Кий"] = { weight = 2, d = "УРН: 30. Вес 2 кг.", prices = { bullet = 100, nc_weap = 150, sc_weap = 200, nv_weap = 180, caravan_weap = 200, klamat_weap = 150, }, item_id = 26, quant = 1},
	["Бензопила"] = { weight = 10, d = "УРН: 35. Вес 10 кг.", prices = { nc_weap = 10000, sc_weap = 15000, nv_weap = 12000, caravan_weap = 16000, bullet = 17000, klamat_weap = 20000, }, item_id = 27, quant = 1},
	["Лопата"] = { weight = 5, d = "УРН: 20. Вес 5 кг.", prices = { nc_weap = 20, sc_weap = 10, nv_weap = 15, caravan_weap = 10, bullet = 30, klamat_weap = 15, }, item_id = 28, quant = 1},
	["Катана"] = { weight = 1, d = "УРН: 50. Вес 1 кг.", prices = { nc_weap = 10000, sc_weap = 10000, nv_weap = 10000, caravan_weap = 15000, bullet = 13000, klamat_weap = 11900, }, item_id = 29, quant = 1},
	["Винтовка резервиста"] = { weight = 4, d = "Однозарядная винтовка. УВС: 64. Вес 4 кг.", prices = { nc_weap = 7000, sc_weap = 10000, nv_weap = 10000, caravan_weap = 12000, bullet = 10000, klamat_weap = 10000, }, item_id = 156, quant = 1},
	["Дубинка"] = { weight = 2, d = "УРН: 28. Вес 2 кг.", prices = { nc_weap = 100, sc_weap = 150, nv_weap = 50, caravan_weap = 30, bullet = 70, klamat_weap = 80, }, item_id = 37, quant = 1},
	["Штурмовая винтовка"] = { weight = 7, d = "Патроны калибра 5,56-мм. УВС 104; Вес 7 кг.", prices = { nc_weap = 50000, sc_weap = 28000, nv_weap = 37000, caravan_weap = 36000, bullet = 40000, klamat_weap = 45000, }, item_id = 36, quant = 1},
	["9-мм пистолет"] = { weight = 1.5, d = "УВС: 49; Вес 1,5 кг.", prices = { nc_weap = 1000, sc_weap = 1000, nv_weap = 1000, caravan_weap = 1000, bullet = 1000, klamat_weap = 1000, }, item_id = 129, quant = 1},
	["9-мм патроны"] = { weight = 0.01, d = "Для 9-мм пистолета; 9-мм пистолета-пулемёта; 9-мм пистолета+; Марии; Вес 0.01 кг.", prices = { nc_weap = 5, sc_weap = 10, nv_weap = 15, caravan_weap = 15, bullet = 15, klamat_weap = 15, }, item_id = 130, quant = 1},
	
	["9-мм патроны x10"] = { weight = 0.1, d = "Для 9-мм пистолета; 9-мм пистолета-пулемёта; 9-мм пистолета+; Марии; Вес 0.1 кг.", prices = { nc_weap = 50, sc_weap = 100, nv_weap = 150, caravan_weap = 150, bullet = 140, klamat_weap = 150, }, item_id = 130, quant = 10},
	["9-мм пистолет-пулемёт"] = { weight = 4, d = "Вес 4 кг.", prices = { nc_weap = 3000, sc_weap = 8000, nv_weap = 2500, caravan_weap = 5000, bullet = 5000, klamat_weap = 5000, }, item_id = 134, quant = 1},
	["Ремонтный набор"] = { weight = 2, d = "Чинит выбранный предмет на 50% его максимального качества. Вес 2 кг.", prices = { nc_weap = 300, sc_weap = 800, nv_weap = 400, caravan_weap = 800, bullet = 400, klamat_weap = 900, }, item_id = 123, quant = 1},
	
	["Патроны 5,56-мм"] = { weight = 0.01, d = "Для Китайского автомата; Китайского автомата+; Китайского автомата Джерико; Штурмовой Винтовки; Штурмовой Винтовки+; Инфильтратора; Дырокола. Вес 0.01 кг.", prices = { sc_weap = 18, nv_weap = 10, caravan_weap = 8, bullet = 30, klamat_weap = 14, }, item_id = 25, quant = 1},
	["Патроны 5,56-мм x100"] = { weight = 0.01, d = "Для Китайского автомата; Китайского автомата+; Китайского автомата Джерико; Штурмовой Винтовки; Штурмовой Винтовки+; Инфильтратора; Дырокола. Вес 1 кг.", prices = { sc_weap = 1800, nv_weap = 1000, caravan_weap = 800, bullet = 3000, klamat_weap = 1400, }, item_id = 25, quant = 100},

	["10-мм патроны"] = { weight = 0.05, d = "Для 10-мм пистолета-пулемёта; 10-мм пистолета; 10-мм пистолета+; Вес 0.05 кг.", prices = { nv_weap = 8, caravan_weap = 15, bullet = 13, klamat_weap = 15, }, item_id = 45, quant = 1},
	["10-мм патроны x50"] = { weight = 0.5, d = "Для 10-мм пистолета-пулемёта; 10-мм пистолета; 10-мм пистолета+; Вес 0.5 кг.", prices = { nv_weap = 400, caravan_weap = 750, bullet = 600, klamat_weap = 750, }, item_id = 45, quant = 50},

	["12.7 патроны"] = { weight = 0.02, d = "Для 12,7-мм пистолета; 12,7-мм пистолета+; 12,7-мм пистолета-пулемёта. Вес 0.02 кг.", prices = { nv_weap = 7, caravan_weap = 10, bullet = 12, klamat_weap = 11, }, item_id = 48, quant = 1},
	["12.7 патроны x100"] = { weight = 2, d = "Для 12,7-мм пистолета; 12,7-мм пистолета+; 12,7-мм пистолета-пулемёта. Вес 2 кг.", prices = { nv_weap = 700, caravan_weap = 1000, bullet = 1200, klamat_weap = 1000, }, item_id = 48, quant = 100},
	
	["Микроядерная Батарея"] = { weight = 0.1, d = "Для Винтовки Гаусса; Бластера Чужих. Вес 0.1 кг.", prices = { roadtown = 30, sc_weap = 70 }, item_id = 137, quant = 1},
	
	["Патрон кал. 357 'Магнум'"] = { weight = 0.02, d = "Для Револьвера Магнум кал. 357. Вес 0.035 кг.", prices = { nv_weap = 20, caravan_weap = 25, bullet = 8, klamat_weap = 18, }, item_id = 141, quant = 1},
	
	["Патрон кал. 45-70"] = { weight = 0.065, d = "Для Охотничий револьвер; Секвойя рейнджера; Вес 0.065 кг.", prices = { nv_weap = 18, caravan_weap = 26, bullet = 11, klamat_weap = 14, }, item_id = 146, quant = 1},
	
	["Патрон кал. 308"] = { weight = 0.055, d = "Для Охотничий револьвер; Секвойя рейнджера; Вес 0.055 кг.", prices = { nv_weap = 40, caravan_weap = 35, bullet = 30, klamat_weap = 50, }, item_id = 154, quant = 1},
	
	["Дробь"] = { weight = 0.05, d = "Для Дробовик; Обрез; Боевой дробовик. Вес 0.05 кг.", prices = { nc_weap = 7, sc_weap = 8, nv_weap = 9, caravan_weap = 10, bullet = 7, klamat_weap = 6, }, item_id = 46, quant = 1},
	["Дробь x10"] = { weight = 0.5, d = "Для Дробовик; Обрез; Боевой дробовик. Вес 0.5 кг.", prices = { nc_weap = 70, sc_weap = 80, nv_weap = 90, caravan_weap = 100, bullet = 65, klamat_weap = 50, }, item_id = 46, quant = 10},
	
	
}

traders = {
	["nc_food"] = {name = "Кафе \"У Кэти Пэрри\"", human = true,veteran=true},
	["nc_medic"] = {name = "Склад лекарств"},
	["sc_food"] = {name = "Склад продуктов",veteran=true},
	["sc_medic"] = {name = "Склад лекарств",veteran=true},
	["nv_food"] = {name = "Кафе"},
	["nv_medic"] = {name = "Пункт продажи лекарств"},
	["ehl_food"] = {name = "Кафе"},
	["ehl_medic"] = {name = "Склад лекарств"},
	["motel_food"] = {name = "Склад продуктов"},
	["motel_medic"] = {name = "Склад лекарств"},
	["megatonna"] = {name = "Бар \"Мегатонна\""},
	["caravan_food"] = {name = "Склад продуктов"},
	["caravan_medic"] = {name = "Склад лекарств"},
	["west_car"] = {name = "Офис Караванщиков"},
	["preston"] = {name = "Доктор Престон", human = true,veteran=true},
	["fatsy"] = {name = "Худышка Фетси", human = true},
	["bonny"] = {name = "Бар \"У руля\"", human = true},
	["perkins"] = {name = "Офис Караванщиков"},
	["gorbov"] = {name = "Профессор Горбов",veteran=true},
	["sayag"] = {name = "Бар \"Золотой Гекко\"",veteran=true},
	["bullet"] = {name = "Снаряд",veteran=true},
	["nc_weap"] = {name = "Склад оружия"},
	["sc_weap"] = {name = "Склад оружия"},
	["nv_weap"] = {name = "Склад оружия"},
	["caravan_weap"] = {name = "Склад оружия"},
	["klamat_weap"] = {name = "Склад оружия"},
	
}

-- Вода
-- купить--нв(30)нд(40)пост(50)су(45)вест(25)ривет(20)клам(45)хостел(30)
-- продажа---нв(10)нд(35)су(40)клам(100)хостел(35)
-- Лапоть гуляхи
-- Купить-нв(80)нд(70)кламат(200)
-- продать-нв(50)нд(65)су(100)клам(180)хостел(95)
-- Психо
-- Купить-нв(110)нд(120)Пост(140)су(80)ривет(70) клам(190)хостел(95)
-- продать-нв(50)нд(80)су(10)клам(290)
-- антирад
-- купить-нв(80)нд(140)пост(160)вест(140)су(110)клам(300)хост(95)
-- продать-нв(100)нд(100)су(100)клам(290)
-- Шашлык из белки
-- купить-нв(40)нд(45)ривет(10)клам(100)хостел(30)
-- продать-нв(30)нд(40)су(45)клам(90)
-- Шашлык из игуаны(тоже самое только + 10 к цене(и при покупке и при продаже)
-- Радтаракан
-- купить-нв(120)нд(100)пост(60)ривет(40)хостел(130)
-- продать-пост(200)
-- Тушёнк
-- Купить-пост(300)вест(200)ривет(240)хостел(150)
-- продать-нв(200)нд(230)клам(350)