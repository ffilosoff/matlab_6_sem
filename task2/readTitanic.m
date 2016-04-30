function []=readTitanic()
    file = 'titanic.csv';
    f = fopen(file);
    w = fopen(strcat(file,'.txt'),'w');
    legend = fgetl(f);
    i = 1;
    while(~feof(f))
        person = textscan(f,'%d %d %d %q %q %d %d %d %s %f %s %s','Delimiter',',');
        i = i + 1;
    end
    ALL = double(max(person{1}));
    ALL_WITHOUT_NAN = sum(person{6}>0);
    
    disp(['Legend:' legend]);
    disp(['Males: ' num2str(sum(strcmp('male',person{5})))]);
    fprintf(w,'Males: %i\n',sum(strcmp('male',person{5})));
    disp(['Female: ' num2str(sum(strcmp('female',person{5})))]);
    fprintf(w,'Females: %i\n',sum(strcmp('female',person{5})));
    disp(['Survived: ' num2str(double(sum(person{2}))./ALL)]);
    fprintf(w,'Survived: %i\n',double(sum(~person{2})));
    disp(['First class: ' num2str(sum((1==person{3}))/ALL)]);
    fprintf(w,'First class: %f\n',sum((1==person{3}))/ALL);
    disp(['Average age: ' num2str(sum((person{6}))/ALL_WITHOUT_NAN)]);
    fprintf(w,'Average age: %f\n',sum((person{6}))/ALL_WITHOUT_NAN);
    disp(['Median age: ' num2str(median(person{6}))]);
    fprintf(w,'Median age: %i\n',median(person{6}));
    disp(['Correlation: ' num2str(corr(double(person{7}),double(person{8})))]);
    fprintf(w,'Correlation: %f\n',corr(double(person{7}),double(person{8})));
    names = (person{4});
%     sex = person{5};
    [l,~] = size(names);
%     female = cell(l);
    k = 1;
    for i = (1:l)
        if(strcmp(person{5}{i},'female'))
            str = person{4}{i};
            str = strsplit(char(str));
            female{k} = str{3};
            k = k + 1;
        end
    end
    female = sort(female);
    [~,l] = size(female);
    last = female{1};
    count = 1;
    max_count = count;
    best_name = last;
    for i=(2:l)
        if(strcmp((female{i}),(last)) == 0) 
            if (count > max_count)
                best_name = last;
                max_count = count;
            end
            last = female{i};
            count = 1;
        else
            count = count + 1;
        end
    end
    
    disp(['Most frequent name: ' best_name]);
    fprintf(w,'Most frequent name: %s\n',best_name);
    fclose(w);
    %% plots
    figure
    subplot(2,2,1)
    h = histogram(person{3},'Normalization', 'pdf');
    counts = h.Values / sum(h.Values);
    bar(counts);
    xlabel 'PClass'
    ylabel 'P'
    subplot(2,2,2)
    C = categorical(strcmp(person{5},'male'),[1 0], {'male','female'});
    h = histogram(C,'Normalization', 'pdf');
    ylabel 'P'
    subplot(2,2,3)
%     C = categorical(strcmp(person{6},),[1 0], {'male','female'});
    h = histogram(person{6},'Normalization', 'pdf');
    xlabel 'Age'
    ylabel 'P'
    subplot(2,2,4)
    h = histogram(person{10},'Normalization', 'pdf');
    xlabel 'Fare'
    ylabel 'P'
%%  3d plot
%     close all %temp string
    
    figure;
    subplot(2,2,1);
    X(1,1:891) = squeeze(person{3});
    X(2,1:891) = squeeze(person{2});
    [N,~]=hist3(double(X'),[3 2]);
    bar3(N/sum(sum(N)));
    str = {'Dead'; 'Alive'; };
    set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
    ylabel 'Pclass';
    zlabel 'P';
    
    subplot(2,2,2);
    X(1,1:891) = squeeze(strcmp(person{5},'male'));
    [N,~]=hist3(double(X'),[2 2]);
    bar3(N/sum(sum(N)));
    sex = {'male', 'female'};
    set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
    set(gca, 'YTickLabel',sex, 'XTick',1:numel(sex));
    zlabel 'P';
    
    subplot(2,2,3:4);
    X(1,1:891) = squeeze(person{10});
    [N,C]=hist3(double(X'),[4 2]);
    bar3(N/sum(sum(N)));
%     sex = {'male', 'female'};
    set(gca, 'XTickLabel',str, 'XTick',1:numel(str));
    set(gca, 'YTickLabel',C{1}, 'XTick',1:numel(C{2}));
    zlabel 'P';
    ylabel 'Fare'
    
    
%     counts = h.Values / sum(h.Values);
%     bar(counts);
%     xlabel 'PClass'
%     ylabel 'P'
%     figure
%     h = histogramm(strcmp(person{5},'male'));
%     xlabel 'Sex'
%     ylabel 'P'
    
    fclose(f);
end