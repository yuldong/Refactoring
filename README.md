# Refactoring
Improving the Design of Exsiting Code

### 第一章 重构 第一个示例

- 如果给一个程序添加特性，但发现代码缺乏良好的结构而不易进行更改，那就先重构这个程序，使其比较容易添加该特性，然后再添加该特性；
- 重构前，先检查自己是否有一套可靠的测试集。这些测试必须有自我检测能力；
- 以微小的步伐修改程序。如果犯下错误，很容易便可发现它；
- 干掉临时变量；
- 忽略性能影响，重构后性能调优(往往有更好的调优方案)；
