# hotelbyte-skills

hotelbyte CLI 的 agent skills 层——酒店域/目的地检索能力的**单一事实源**。

- 消费方:gotry(dsh 插件的工具知识源)、任何 dsh/agent 用户
- 设计文档:[gotry/docs/hotelbyte-skills-design.md](https://github.com/Danceiny/gotry/blob/main/docs/hotelbyte-skills-design.md)(issue Danceiny/gotry#5)
- 域边界:酒店域库存走本 skill(hbcli→hotel-be);通用外部事实走 agent-reach;公司系统走宿主 skill

## 安装(agent 侧)

```sh
git clone https://github.com/Danceiny/hotelbyte-skills ~/.claude/skills/hotelbyte-skills
```

License: MIT
