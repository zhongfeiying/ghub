
_ENV = module_seeall(...,package.seeall)
local db = {
	[1] = {
		Kind = 'BRANCH'; --�����ļ��л����ļ�
		Attr = {--�ڵ㸽�ŵ�����
			['hello'] = 'world';
		};
		Color = '200 200 200';--�ڵ���ʾ����ɫ
		Title = 'Word';--�ڵ���ʾ�ı���
		Datas = {--����ǵ�ǰ�ڵ����ļ��У���ô�����ӽڵ����ݴ�������key��Ӧ�ı���
			[1] = {
				Kind = 'BRANCH';
				Attr = {
					['NBA'] = true;
				};
				Color = '255 1 1';
				Title = 'Hello';
			};
			[2] = {
				Kind = 'LEAF';
				Attr = {
					['CBN'] = true;
				};
				Color = '1 1 1';
				Title = 'LUA';
			};
		};
	};
}

function get_test_datas()
	return db
end