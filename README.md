# drawJuliaSet
撰寫四個function name、id、drawJuliaSet、main。name function為印出組別和三位組員姓名，id function為讀取使用者的輸入，讀取三個組員的學號，再讀取使用者輸入的command ，檢查是否為p，是的話就將剛剛讀到的學號都印出，並將學號加總然後印出加總後的值，不是的話便跳出做學號加總然後回到main。drawJuliaSet function 函式主要用來計算並決定frame二維陣列裡每個元素的值，並用元素值決定投影至畫面上的元素。main function使用c撰寫，負責呼叫前三個函式，完成後將組別、組員、學號和加總後的學號印出，並畫出Julia Set動畫(動畫最後包含賀年卡以及姓名學號)。