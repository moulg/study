--[[
	物体包围盒，一堆圆，以物体中心点为坐标原点,圆心为(a,b),半径为r
]]

bonding_box_config = {
	[1] = {id = 1, data = {[1] = {r = 12,a = 0,b = 0,}, [2] = {r = 12,a = -13,b = 0,}, [3] = {r = 12,a = 13,b = 0,}, }, },
	[2] = {id = 2, data = {[1] = {r = 30,a = 0,b = 0,}, }, },
	[3] = {id = 3, data = {[1] = {r = 40,a = -20,b = 0,},[2] = {r = 40,a = 20,b = 0,}, }, },
	[4] = {id = 4, data = {[1] = {r = 23,a = -12,b = 0,},[2] = {r = 23,a = 12,b = 0,}, }, },
	[5] = {id = 5, data = {[1] = {r = 25,a = -14,b = 0,},[2] = {r = 25,a = 14,b = 0,}, }, },
	[6] = {id = 6, data = {[1] = {r = 20,a = 35,b = 0,},[2] = {r = 24,a = 17,b = 0,}, [3] = {r = 28,a = -5,b = 0,},}, },
	[7] = {id = 7, data = {[1] = {r = 20,a = 15,b = 18,},[2] = {r = 17,a = -12,b = -1,}, [3] = {r = 17,a = -8,b = -23,},}, },
	[8] = {id = 8, data = {[1] = {r = 54,a = 0,b = 0,},}, },
	[9] = {id = 9, data = {[1] = {r = 67,a = 0,b = 0,},}, },
   [10] = {id = 10,data = {[1] = {r = 39,a = 36,b = 0,}, [2] = {r = 16,a = -38,b = -14,},},},
   [11] = {id = 11,data = {[1] = {r = 40,a = -66,b = -17,}, [2] = {r = 40,a = -2,b = -5,}, [3] = {r = 50,a = 58,b = -1,},},},
   [12] = {id = 12,data = {[1] = {r = 9,a = 169,b = 6,}, [2] = {r = 13,a = 152,b = 6,}, [3] = {r = 16,a = 127,b = 5,},
                          [4] = {r = 19,a = 96,b = 2,}, [5] = {r = 23,a = 63,b = 6,}, [6] = {r = 42,a = 22,b = 0,},
                          [7] = {r = 30,a = -40,b = -2,}, [8] = {r = 20,a = -78,b = -1,}, [9] = {r = 14,a = -104,b = 0,},
                          [10] = {r = 12,a = -128,b = 3,}, [11] = {r = 23,a = -78,b = 8,}, [12] = {r = 19,a = -12,b = -38,},
                          [13] = {r = 20,a = -13,b = -68,}, [14] = {r = 19,a = -18,b = 70,}, [15] = {r = 20,a = -19,b = 28,},},},
   [13] = {id = 13, data = {[1] = {r = 85,a = 53,b = 0,},}, },
   [14] = {id = 14, data = {[1] = {r = 73,a = 80,b = 0,},[2] = {r = 40,a = -39,b = 0,}, }, },
   [15] = {id = 15, data = {[1] = {r = 25,a = 175,b = 0,},[2] = {r = 55,a = 111,b = 0,}, [3] = {r = 67,a = 34,b = 0,}, [4] = {r = 40,a = -56,b = 0,}, 
                            [5] = {r = 39,a = -120,b = 0,}, }, },
   [16] = {id = 16, data = {[1] = {r = 57,a = 28,b = 0,}, [2] = {r = 104,a = -122,b = 20,}, [3] = {r = 120,a = 167,b = 0,}, }, },
   [17] = {id = 17, data = {[1] = {r = 125,a = 0,b = 0,},}, },
   [18] = {id = 18,data = {[1] = {r = 16,a = 273,b = 1,}, [2] = {r = 36,a = 224,b = 0,}, [3] = {r = 79,a = 122,b = 2,}, 
                           [4] = {r = 66,a = 46,b = 2,},   [5] = {r = 42,a = -73,b = 3,},  [6] = {r = 31,a = -128,b = 3,},
                           [7] = {r = 60,a = -207,b = 8,}, [8] = {r = 34,a = 3,b = 79,},   [9] = {r = 30,a = 3,b = -89,},},},

   [19] = {id = 19,data = {[1] = {r = 39,a = 194,b = 10,}, [2] = {r = 46,a = 126,b = -5,}, [3] = {r = 44,a = 40,b = 2,}, 
                           [4] = {r = 42,a = -26,b = 2,}, [5] = {r = 28,a = -89,b = -3,}, [6] = {r = 17,a = -125,b = -3,},},},
   [20] = {id = 20,data = {[1] = {r = 64,a = 0,b = 0,}, } ,},
   [21] = {id = 21,data = {[1] = {r = 120,a = 0,b = 0,}, } ,},
   [22] = {id = 22,data = {[1] = {r = 120,a = 0,b = 0,}, } ,},
   [23] = {id = 23,data = {[1] = {r = 15,a = -15,b = 0,},[2] = {r = 15,a = 0,b = 0,}, [3] = {r = 15,a = 15,b = 0,}, } ,}
}