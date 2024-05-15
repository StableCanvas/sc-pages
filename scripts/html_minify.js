const fs = require("fs");
const minify = require("html-minifier-terser").minify;

const inputFile = process.argv[2] || "";
const outputFile = process.argv[3] || "";

if (!fs.existsSync(inputFile)) {
  throw new Error("输入文件不存在！");
}
if (!outputFile.trim()) {
  throw new Error("输出文件名不能为空！");
}

fs.readFile(inputFile, "utf8", async (err, html) => {
  if (err) {
    console.error("读取文件时出错:", err);
    return;
  }

  const minified = await minify(html, {
    removeComments: true,
    collapseWhitespace: true,
    minifyCSS: true,
    minifyJS: true,
  });

  fs.writeFile(outputFile, minified, (err) => {
    if (err) {
      console.error("写入文件时出错:", err);
      return;
    }
    console.log("压缩成功！", outputFile);
  });
});
