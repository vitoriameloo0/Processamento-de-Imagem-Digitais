classdef Trabalho_vi < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        ImagemcomFiltroLabel        matlab.ui.control.Label
        ImagemOriginalLabel         matlab.ui.control.Label
        EditField2                  matlab.ui.control.NumericEditField
        EditField2Label             matlab.ui.control.Label
        AplicarFiltroButton         matlab.ui.control.Button
        EditField                   matlab.ui.control.NumericEditField
        EditFieldLabel              matlab.ui.control.Label
        SelecioneumaOpoButtonGroup  matlab.ui.container.ButtonGroup
        Opt4Button                  matlab.ui.control.RadioButton
        Opt3Button                  matlab.ui.control.RadioButton
        Opt2Button                  matlab.ui.control.RadioButton
        Opt1Button                  matlab.ui.control.RadioButton
        FiltrosDropDown             matlab.ui.control.DropDown
        FiltrosDropDownLabel        matlab.ui.control.Label
        AbrirImagemButton           matlab.ui.control.Button
        Image2                      matlab.ui.control.Image
        Image                       matlab.ui.control.Image
    end

    
    properties (Access = private)
         caminhoArq = "";
         nomeImagem = "";
         imgOriginal;
    end
    
    methods (Access = private)
        
        function startupFcn(app)
            app.UIFigure.AutoResizeChildren = 'on';
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: AbrirImagemButton
        function AbrirImagemButtonPushed(app, event)
            %pego o nome da imagem e o caminho pela funcao q abre a janelinha
            [file, path] = uigetfile('*', "Escolha uma Imagem"); 
            app.nomeImagem = file;

            file = strcat (path, file);
            if(file ~= "")
                app.imgOriginal = file;
                app.Image.ImageSource = file;
                %app.Image2.ImageSource = file;
                
            end 
            
        end

        % Selection changed function: SelecioneumaOpoButtonGroup
        function SelecioneumaOpoButtonGroupSelectionChanged(app, event)
            selectedButton = app.SelecioneumaOpoButtonGroup.SelectedObject;

            if (app.FiltrosDropDown.Value == "Passa-Alta")
                switch selectedButton
                    case app.Opt1Button
                        app.EditField.Visible = "on"; 
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Valor do Kernel";

                    case app.Opt2Button
                        app.EditField.Visible = "on"; 
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Fator Reforço";
                end
            end

            if (app.FiltrosDropDown.Value == "Passa-Baixa")
                  switch selectedButton 
                    case app.Opt1Button  
                        app.EditField.Visible = "on";
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Nivel";

                        app.EditField2.Visible = "off";
                        app.EditField2Label.Visible = "off";
                  
                    case app.Opt2Button
                        app.EditField.Visible = "on";
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Linhas";

                        app.EditField2.Visible = "on";
                        app.EditField2Label.Visible = "on";
                        app.EditField2Label.Text = "Coluna";
                 end
            end

            if (app.FiltrosDropDown.Value == "Ruídos")
                switch selectedButton
                    case app.Opt1Button
                        app.EditField.Visible = "on";
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Ruido-Speckle";
                        app.EditField2.Visible = "off";
                        app.EditField2Label.Visible = "off";

                    case app.Opt2Button
                        app.EditField.Visible = "on";
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Valor Médio";
                        app.EditField2.Visible = "on";
                        app.EditField2Label.Visible = "on";
                        app.EditField2Label.Text = "Variancia";

                    case app.Opt3Button
                        app.EditField.Visible = "on";
                        app.EditFieldLabel.Visible = "on";
                        app.EditFieldLabel.Text = "Densidade";
                        app.EditField2.Visible = "off";
                        app.EditField2Label.Visible = "off";
                    case app.Opt4Button
                        app.EditField.Visible = "off";
                        app.EditFieldLabel.Visible = "off";
                        app.EditField2.Visible = "off";
                        app.EditField2Label.Visible = "off";

                end 
            end
        end

        % Value changed function: FiltrosDropDown
        function FiltrosDropDownValueChanged(app, event)
            valor = app.FiltrosDropDown.Value;
            
            app.SelecioneumaOpoButtonGroup.Visible = "off";
            app.EditField.Visible = "off";
            app.EditFieldLabel.Visible = "off";
            app.EditField2.Visible = "off";
            app.EditField2Label.Visible = "off";

             switch valor

                 case "Escala de Cinza"
                     app.EditField.Visible = "off"; 
                     app.EditFieldLabel.Visible = "off";
                     app.EditField2.Visible = "off";
                     app.EditField2Label.Visible = "off";
                     app.SelecioneumaOpoButtonGroup.Visible = "off";

                 case "Threshold"
                     app.EditField.Visible = "on"; 
                     app.EditFieldLabel.Visible = "on";
                     app.EditFieldLabel.Text = "Valor do Limiar";
                     app.EditField2.Visible = "off";
                     app.EditField2Label.Visible = "off";
                     app.SelecioneumaOpoButtonGroup.Visible = "off";

                 case "Passa-Alta"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt2Button.Visible = "on";
                     app.Opt3Button.Visible = "off";
                     app.Opt4Button.Visible = "off";

                     app.Opt1Button.Text = "Básico";
                     app.Opt2Button.Text = "Alto Reforço";


                     %%falta variavel

                 case "Passa-Baixa"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt2Button.Visible = "on";
                     app.Opt3Button.Visible = "off";
                     app.Opt4Button.Visible = "off";

                     app.Opt1Button.Text = "Média (Básico)";
                     app.Opt2Button.Text = "Mediana";

                 case "Prewitt"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt1Button.Text = "Horizontal";
                     app.Opt2Button.Visible = "on";
                     app.Opt2Button.Text = "Vertical";
                     app.Opt3Button.Visible = "on";
                     app.Opt3Button.Text = "Horizontal + Vertical";
                     app.Opt4Button.Visible = "on";
                     app.Opt4Button.Text = "Edge";
                     
                 case "Sobel"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt1Button.Text = "Horizontal";
                     app.Opt2Button.Visible = "on";
                     app.Opt2Button.Text = "Vertical";
                     app.Opt3Button.Visible = "on";
                     app.Opt3Button.Text = "Horizontal + Vertical";
                     app.Opt4Button.Visible = "on";
                     app.Opt4Button.Text = "Edge";

                 case "Log"
                     app.EditField.Visible = "on";
                     app.EditFieldLabel.Visible = "on";
                     app.EditField2.Visible = "on";
                     app.EditField2Label.Visible = "on";

                     app.EditFieldLabel.Text = "Sigma";
                     app.EditField2Label.Text = "Tamanho da Matriz";
                   
                 case "Ruídos"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt2Button.Visible = "on";
                     app.Opt3Button.Visible = "on";
                     app.Opt4Button.Visible = "on";
    
                     app.Opt1Button.Text = "Speckle";
                     app.Opt2Button.Text = "Gaussiano";
                     app.Opt3Button.Text = "Salt & Papper";
                     app.Opt4Button.Text = "Poissen";

                 case "Histograma"
                     app.SelecioneumaOpoButtonGroup.Visible = "on";
                     app.Opt1Button.Visible = "on";
                     app.Opt2Button.Visible = "on";
                     app.Opt3Button.Visible = "on";
                     app.Opt4Button.Visible = "on";

                     app.Opt1Button.Text = "Escala Cinza";
                     app.Opt2Button.Text = "RGB";
                     app.Opt3Button.Text = "Equalizado";
                     app.Opt4Button.Text = "Equalizado Adaptativo";

                 case "Contagem Simples"
                     app.EditField.Visible = "off"; 
                     app.EditFieldLabel.Visible = "off";
                     app.EditFieldLabel.Text = "Valor do Limar";
                     app.EditField2.Visible = "off";
                     app.EditField2Label.Visible = "off";
                     app.SelecioneumaOpoButtonGroup.Visible = "off";
                     
             end
        end

        % Value changed function: EditField
        function EditFieldValueChanged(app, event)
            %valor = app.EditField.Value;
            
        end

        % Button pushed function: AplicarFiltroButton
        function AplicarFiltroButtonPushed(app, event)
            valor  = app.EditField.Value;
            disp(valor);

            if app.imgOriginal ~= ""
                img = imread(app.imgOriginal);
                disp(app.FiltrosDropDown.Value);

                switch app.FiltrosDropDown.Value
                    case "Escala de Cinza"
                        try
                            imgGray = im2gray(img);
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Escala_Cinza" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                
                            % Salvar a imagem binarizada
                            imwrite(imgGray, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Threshold"
                        if valor >= 0 && valor <= 1
                            try
                                % Converter para escala de cinza se necessário
                                if size(img, 3) == 3
                                    img = rgb2gray(img);
                                end
                                imgBi = imbinarize(img, valor);
                                %imshow(imgBi);

                                % Gerar um timestamp para garantir nomes de arquivos únicos
                                timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                nomeArq = "Threshold" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                
                                % Salvar a imagem binarizada
                                imwrite(imgBi, nomeCaminho);
                                app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                            

                           catch ME
                               disp('Erro ao aplicar filtro:');
                               disp(ME.message);
                            end
                        end

                    case "Passa-Alta"
    
                        selecaoOpt = app.SelecioneumaOpoButtonGroup.SelectedObject;
                        switch selecaoOpt
                            case app.Opt1Button % Passa Alta - Basica
                                try
                                   % Verifica se a imagem é colorida ou em tons de cinza
                                    if size(img, 3) == 3  % Imagem colorida (RGB)
                                        % Separar os três canais (R, G, B)
                                        img = imread(app.imgOriginal);
                                        imgR = img(:,:,1); % Canal vermelho
                                        imgG = img(:,:,2); % Canal verde
                                        imgB = img(:,:,3); % Canal azul
                    
                                        % Aplicar o filtro passa-alta em cada canal de cor
                                        kernelPA = [-1, -1, -1; -1, app.EditField.Value, -1; -1, -1, -1];
                                        PA_basica_R = imfilter(imgR, kernelPA, 'replicate');
                                        PA_basica_G = imfilter(imgG, kernelPA, 'replicate');
                                        PA_basica_B = imfilter(imgB, kernelPA, 'replicate');
                    
                                        % Recombinar os canais de volta em uma imagem RGB
                                        PA_basica = cat(3, PA_basica_R, PA_basica_G, PA_basica_B); 
                                    else
                                        % Imagem em preto e branco (tons de cinza)
                                        % Aplicar o filtro passa-alta na imagem de tons de cinza
                                        img = imread(app.imgOriginal);
                                        kernelPA = [-1, -1, -1; -1, app.EditField.Value, -1; -1, -1, -1];
                                        PA_basica = imfilter(img, kernelPA, 'replicate');
                                    end

                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Passa_Alta_Basica" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                
                                    % Salvar a imagem Passa-Alta
                                    imwrite(PA_basica, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end
                            case app.Opt2Button % Passa Alta - Alto Reforço
                                if valor >= 1
                                    try
                                        % Verifica se a imagem é colorida ou em tons de cinza
                                        img = imread(app.imgOriginal);
                                        if size(img, 3) == 3  % Imagem colorida (RGB)
                                            % Separar os três canais (R, G, B) 
                                            imgR = img(:,:,1); % Canal vermelho
                                            imgG = img(:,:,2); % Canal verde
                                            imgB = img(:,:,3); % Canal azul
                    
                                            % Suavização em cada canal (para cálculo do passa-alta)
                                            h = fspecial('gaussian', [5, 5], 2);
                                            imgSuavizadaR = imfilter(imgR, h, 'replicate');
                                            imgSuavizadaG = imfilter(imgG, h, 'replicate');
                                            imgSuavizadaB = imfilter(imgB, h, 'replicate');
                    
                                            % Passa-alta em cada canal
                                            imgPassaAltaR = imgR - imgSuavizadaR;
                                            imgPassaAltaG = imgG - imgSuavizadaG;
                                            imgPassaAltaB = imgB - imgSuavizadaB;
                    
                                            % Aplicar o filtro de alto reforço em cada canal
                                            imgAltoReforco_R = valor * imgR + imgPassaAltaR;
                                            imgAltoReforco_G = valor * imgG + imgPassaAltaG;
                                            imgAltoReforco_B = valor * imgB + imgPassaAltaB;
                    
                                            % Recombinar os canais de volta em uma imagem RGB
                                            imgAltoReforco = cat(3, imgAltoReforco_R, imgAltoReforco_G, imgAltoReforco_B);

                                        else % Imagem em preto e branco (tons de cinza)
                                            % Suavização                                       
                                            h = fspecial('gaussian', [5, 5], 2);
                                            imgSuavizada = imfilter(img, h, 'replicate');
                                            % Calcular o filtro passa-alta
                                            imgPassaAlta = img - imgSuavizada;
    
                                            % Aplicar o filtro de alto reforço
                                            imgAltoReforco = valor * img + imgPassaAlta;
                                        end
                                        
                                        % Gerar um timestamp para garantir nomes de arquivos únicos
                                        timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                        nomeArq = "Passa_Alta_Basica" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                        nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                    
                                        % Salvar a imagem Passa-Alta
                                        imwrite(imgAltoReforco, nomeCaminho);
                                        app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                    catch ME
                                        disp('Erro ao aplicar filtro:');
                                        disp(ME.message);
                                    end
                                end
                        end
                    case "Passa-Baixa"
                        selecioneOp = app.SelecioneumaOpoButtonGroup.SelectedObject;

                        switch selecioneOp
                            case app.Opt1Button % Passa Baixa Media 
                                if valor > 0
                                    try
                                        if size(img, 3) == 3 % se for colorida
                                            % Separar os canais de cor (R, G, B)
                                            imgR = img(:,:,1); % Canal vermelho
                                            imgG = img(:,:,2); % Canal verde
                                            imgB = img(:,:,3); % Canal azul
                    
                                            % Criar o kernel da média
                                            Media = fspecial('average', valor);
                    
                                            % Aplicar o filtro de média a cada canal separadamente
                                            imgR_filt = imfilter(imgR, Media, 'replicate');
                                            imgG_filt = imfilter(imgG, Media, 'replicate');
                                            imgB_filt = imfilter(imgB, Media, 'replicate');
                    
                                            % Recombinar os canais filtrados
                                            imgSuavisada = cat(3, imgR_filt, imgG_filt, imgB_filt);

                                        else
                                            Media = fspecial('average', valor);
                                            imgSuavisada = imfilter(img, Media, 'replicate');
                                        end 

                                        % Gerar um timestamp para garantir nomes de arquivos únicos
                                        timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                        nomeArq = "Passa_Baixa_Media" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                        nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                    
                                        % Salvar a imagem Passa-Alta
                                        imwrite(imgSuavisada, nomeCaminho);
                                        app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                    catch ME
                                        disp('Erro ao aplicar filtro:');
                                        disp(ME.message);
                                    end
                                end
                            case app.Opt2Button % Passa Baixa Mediana
                                try
                                    linha1 = app.EditField.Value;
                                    linha2 = app.EditField2.Value;
                                    tamanhoJanela = [linha1, linha2];

                                    if size(img, 3) == 3 %se a imagem for colorida
                                       % Separar os canais de cor (R, G, B)
                                        imgR = img(:,:,1); % Canal vermelho
                                        imgG = img(:,:,2); % Canal verde
                                        imgB = img(:,:,3); % Canal azul
                    
                                        % Aplicar o filtro de mediana a cada canal separadamente
                                        imgR_filt = medfilt2(imgR, tamanhoJanela);
                                        imgG_filt = medfilt2(imgG, tamanhoJanela);
                                        imgB_filt = medfilt2(imgB, tamanhoJanela);
                    
                                        % Recombinar os canais filtrados
                                        imgFiltrada = cat(3, imgR_filt, imgG_filt, imgB_filt);
                                    else % se a imagem nao for colorida
                                        imgFiltrada = medfilt2(img,tamanhoJanela);
                                    end
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Passa_Baixa_Mediana" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                    
                                    % Salvar a imagem Passa-Baixa
                                    imwrite(imgFiltrada, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end
                        end
                    
                    case "Roberts"
                        try
                            if size(img, 3) == 3
                                img = rgb2gray(img);
                            end
                            robertsEdg = edge(img, "roberts");
                            % Gerar um timestamp para garantir nomes de arquivos únicos
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Roberts" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                        
                            % Salvar a imagem 
                            imwrite(robertsEdg, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Prewitt"
                        if size(img, 3) == 3
                            img = rgb2gray(img);
                        end
                        h = fspecial('prewitt');
                        selecioneOp = app.SelecioneumaOpoButtonGroup.SelectedObject;

                        switch selecioneOp
                            case app.Opt1Button %Prewitt Horizontal
                                try
                                    preH = imfilter(img, h);

                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Prewitt_Horizontal" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(preH, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt2Button %Prewitt Vertical
                                try
                                    preV = imfilter(img, h');

                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Prewitt_Vertical" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(preV, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt3Button %Prewitt Horizontal-Vertical
                                try
                                    preh = imfilter(img, h);
                                    prev = imfilter(img, h');
                                    prehv = ph + pv;
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Prewitt_HorVer" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(prehv, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt4Button % Prewitt Edge
                                try
                                    preEdge = edge(img, "prewitt");
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Prewitt_Edge" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(preEdge, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end
                        end

                    case "Sobel"
                        if size(img, 3) == 3
                            img = rgb2gray(img);
                        end
                        h = fspecial('sobel');
                        selecioneOp = app.SelecioneumaOpoButtonGroup.SelectedObject;

                        switch selecioneOp
                            case app.Opt1Button % Sobel Horizontal
                                try 
                                    sobelH = imfilter(img, h);
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Sobel_Horizontal" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(sobelH, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt2Button % Sobel Vertical
                                try 
                                    sobelV = imfilter(img, h');
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Sobel_Vertical" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem 
                                    imwrite(sobelV, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt3Button % Sobel Horizontal-Vertical
                                try 
                                    sobelH = imfilter(img, h);
                                    sobelV = imfilter(img, h');
                                    sobelHV = sobelH + sobelV;
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Sobel_HorVer" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem
                                    imwrite(sobelHV, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt4Button % Sobel Edge
                                try 
                                    sobelEdge = edge(img, "sobel"); 
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Sobel_Edge" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                                    % Salvar a imagem
                                    imwrite(sobelEdge, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end
                               
                        end

                    case "Log"
                        if size(img, 3) == 3
                            img = rgb2gray(img);
                        end
                        try
                            sigma = app.EditField.Value;
                            tamanhoMatriz = app.EditField2.Value;                               
                            parametroImg = fspecial('log', [tamanhoMatriz , tamanhoMatriz], sigma);  
                            imgFiltro = imfilter(img, parametroImg);

                            % Gerar um timestamp para garantir nomes de arquivos únicos
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Log" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                            % Salvar a imagem 
                            imwrite(imgFiltro, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Zerocross"
                        if size(img, 3) == 3
                            img = rgb2gray(img);
                        end
                        try
                            aplicacao1 = fspecial('laplacian');
                            imgFiltro = edge(img, 'zerocross', aplicacao1);
                            % Gerar um timestamp para garantir nomes de arquivos únicos
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Zerocross" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                            % Salvar a imagem 
                            imwrite(imgFiltro, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Canny"
                        if size(img, 3) == 3
                            img = rgb2gray(img);
                        end
                        try 
                            imgFiltro = edge(img, 'canny');
                            % Gerar um timestamp para garantir nomes de arquivos únicos
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Zerocross" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                
                            % Salvar a imagem 
                            imwrite(imgFiltro, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Ruídos"
                        selecioneOp = app.SelecioneumaOpoButtonGroup.SelectedObject;

                        switch selecioneOp
                            case app.Opt1Button
                                try
                                    ruidoSpeckler = app.EditField.Value;
                                    imgSpeckle = imnoise(img, 'speckle', ruidoSpeckler);
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Ruído_Speckle" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                        
                                    % Salvar a imagem 
                                    imwrite(imgSpeckle, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt2Button
                                try
                                    valorMedio = app.EditField.Value;
                                    varianciaRuido = app.EditField2.Value;
                                    imgGaussiana = imnoise(img, 'gaussian', valorMedio, varianciaRuido);
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Ruído_Gaussian" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                        
                                    % Salvar a imagem 
                                    imwrite(imgGaussiana, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt3Button
                                try
                                    densidade = app.EditField.Value;
                                    imgSaltAndPepper = imnoise(img, 'salt & pepper', densidade);
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Ruído_SaltAndPepper" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                        
                                    % Salvar a imagem 
                                    imwrite(imgSaltAndPepper, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt4Button
                                try
                                    imgPoisson = imnoise(img, 'poisson');
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "Ruído_Poisson" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                        
                                    % Salvar a imagem 
                                    imwrite(imgPoisson, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end
                        end
                    
                    case "Watershed"
                        try
                            if size(img, 3) == 3
                                img = rgb2gray(img);
                            end
                            binImg = imbinarize(img); % Binarizar a imagem
                            
                            % Complemento da imagem (invertendo o foreground e background)
                            binImg = imcomplement(binImg);
                            
                            % Aplicar a Transformada da Distância
                            distTransform = bwdist(binImg);
                            
                            % Inversão da Transformada da Distância (necessária para Watershed)
                            distTransform = -distTransform;
                            
                            % Marcar os mínimos da transformada da distância como marcadores iniciais
                            mask = imextendedmin(distTransform, 2);
                            
                            % Modificar a transformada para impedir a divisão dos objetos
                            distTransform = imimposemin(distTransform, mask);
                            
                            % Aplicar o Watershed
                            watershedLabels = watershed(distTransform);
                            
                            % Criar uma imagem de borda a partir da segmentação Watershed
                            watershedBorders = watershedLabels == 0;
                            
                            % Superpor as bordas da segmentação na imagem original
                            segmentedImg = img;
                            segmentedImg(watershedBorders) = 255;
                            % Gerar um timestamp para garantir nomes de arquivos únicos
                            timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                            nomeArq = "Watersheld" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                            nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                            
                            % Salvar a imagem 
                            imwrite(segmentedImg, nomeCaminho);
                            app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app   
                        catch ME
                            disp('Erro ao aplicar filtro:');
                            disp(ME.message);
                        end

                    case "Histograma"
                        selecioneOp = app.SelecioneumaOpoButtonGroup.SelectedObject;
                        switch selecioneOp
                            case app.Opt1Button % Histograma da Escala de Cinza
                                try
                                    if size(img, 3) == 3
                                        img = rgb2gray(img);
                                    end
                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "HistogramaEC" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                                    
                                    % Salvar a imagem 
                                    imwrite(img, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                    imhist(img);
                                    title('Histograma de Escala de Cinza');

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt2Button % Histograma RGB % tem que arrumar
                                try
                                    % Verifica se a imagem é RGB
                                    if size(img, 3) == 3
                                        % Extrai os canais de cor
                                        redChannel = img(:,:,1);
                                        greenChannel = img(:,:,2);
                                        blueChannel = img(:,:,3);
                            
                                        % Gerar um timestamp para garantir nomes de arquivos únicos
                                        timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                        nomeArq = "HistogramaRGB_" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                        nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                                
                                        % Salvar a imagem 
                                        imwrite(img, nomeCaminho);
                                        app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                            
                                        % Plotar os histogramas dos canais
                                        figure;
                                        subplot(3,1,1);
                                        imhist(redChannel);
                                        title('Histograma do Canal Vermelho');
                                        
                                        subplot(3,1,2);
                                        imhist(greenChannel);
                                        title('Histograma do Canal Verde');
                                        
                                        subplot(3,1,3);
                                        imhist(blueChannel);
                                        title('Histograma do Canal Azul');
                                    else
                                        error('A imagem não é RGB. Não é possível gerar o histograma RGB.');
                                    end
                                
                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt3Button % Histograma Equalizado TEM QUE ARRUMAR
                                try
                                    if size(img, 3) == 3
                                        img = rgb2gray(img);
                                    end
                                    imgEqualizada = histeq(img); % Equalizar o histograma

                                    % Gerar um timestamp para garantir nomes de arquivos únicos
                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "HistogramaEC" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                                    
                                    % Salvar a imagem 
                                    imwrite(imgEqualizada, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
            
                                    imhist(imgEqualizada);
                                    title('Histograma Equalizado');

                                catch ME
                                    disp('Erro ao aplicar filtro:');
                                    disp(ME.message);
                                end

                            case app.Opt4Button
                                try
                                    if size(img, 3) == 3
                                        img = rgb2gray(img);
                                    end
                                    imgCLAHE = adapthisteq(img); % Aplicar CLAHE

                                    timestamp = datestr(now, 'yyyymmdd_HHMMSS');
                                    nomeArq = "HistogramaEC" + timestamp + "_" + app.nomeImagem + ".png"; % Nome do arquivo inclui timestamp
                                    nomeCaminho = fullfile(app.caminhoArq, nomeArq); % Caminho da imagem
                                                                    
                                    % Salvar a imagem 
                                    imwrite(imgCLAHE, nomeCaminho);
                                    app.Image2.ImageSource = nomeCaminho; % Atualiza a exibição da imagem no app
                                    imhist(imgCLAHE);
                                    title('Histograma CLAHE');

                                catch ME
                                    disp('Erro ao aplicar filtro:'); 
                                    disp(ME.message);
                                end
                        end
                    case "Contagem Simples"
                        try
                        % Converter para escala de cinza
                            i = rgb2gray(img);
                            
                            % Inversão de intensidade (se necessário, com avaliação do efeito)
                            limiar = 255 - i;
                    
                            % Aplicar binarização (pode ajustar o método ou limiar se necessário)
                            bw = imbinarize(limiar);
                    
                            % Remover pequenos objetos para evitar ruído (ajustar minObjectSize conforme necessário)
                            minObjectSize = 50;  % Defina o tamanho mínimo de objetos que você deseja contar
                            bw = bwareaopen(bw, minObjectSize);
                    
                            % Preencher buracos (verifique se isso realmente é necessário para sua imagem)
                            bw2 = imfill(bw, 'holes');
                    
                            % Criar uma imagem lógica
                            L = logical(bw2);
                    
                            % Usar 'regionprops' para obter as propriedades das regiões
                            s = regionprops(L, 'Centroid');
                            figure, imshow(bw2), title('Objetos contados');
                    
                            hold on
                                % Circular as regiões
                                boundaries = bwboundaries(L);
                                for k = 1:length(boundaries)
                                    boundary = boundaries{k};
                                    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
                                end
                    
                                % Marcar os centróides das regiões
                                for k = 1:numel(s)
                                    c = s(k).Centroid;
                                    text(c(1), c(2), sprintf('%d', k), ...
                                        'HorizontalAlignment', 'center', ...
                                        'VerticalAlignment', 'middle', ...
                                        'Color', 'black');
                                end
                    
                                % Contar o número total de objetos
                                numObjects = numel(s);
                    
                                % Exibir o valor total da contagem na imagem
                                text(size(bw2, 2) - 10, 10, sprintf('Total: %d', numObjects), ...
                                    'HorizontalAlignment', 'right', ...
                                    'VerticalAlignment', 'top', ...
                                    'Color', 'green', ...
                                    'FontSize', 12, ...
                                    'FontWeight', 'bold');
                            hold off;

                        catch ME
                            disp('Erro ao aplicar filtro:'); 
                            disp(ME.message);
                        end
                end

            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9255 0.9412 0.9451];
            app.UIFigure.Position = [100 100 1008 726];
            app.UIFigure.Name = 'MATLAB App';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [80 364 464 325];

            % Create Image2
            app.Image2 = uiimage(app.UIFigure);
            app.Image2.Position = [81 8 464 325];

            % Create AbrirImagemButton
            app.AbrirImagemButton = uibutton(app.UIFigure, 'push');
            app.AbrirImagemButton.ButtonPushedFcn = createCallbackFcn(app, @AbrirImagemButtonPushed, true);
            app.AbrirImagemButton.BackgroundColor = [0.102 0.7373 0.6118];
            app.AbrirImagemButton.FontSize = 14;
            app.AbrirImagemButton.FontWeight = 'bold';
            app.AbrirImagemButton.FontColor = [0.0118 0.0157 0.0196];
            app.AbrirImagemButton.Position = [739 642 160 47];
            app.AbrirImagemButton.Text = 'Abrir Imagem';

            % Create FiltrosDropDownLabel
            app.FiltrosDropDownLabel = uilabel(app.UIFigure);
            app.FiltrosDropDownLabel.BackgroundColor = [0.9255 0.9412 0.9451];
            app.FiltrosDropDownLabel.HorizontalAlignment = 'center';
            app.FiltrosDropDownLabel.FontSize = 14;
            app.FiltrosDropDownLabel.FontWeight = 'bold';
            app.FiltrosDropDownLabel.FontColor = [0.0118 0.0157 0.0196];
            app.FiltrosDropDownLabel.Position = [673 577 65 31];
            app.FiltrosDropDownLabel.Text = 'Filtros';

            % Create FiltrosDropDown
            app.FiltrosDropDown = uidropdown(app.UIFigure);
            app.FiltrosDropDown.Items = {'Escala de Cinza', 'Threshold', 'Passa-Alta', 'Passa-Baixa', 'Roberts', 'Prewitt', 'Sobel', 'Log', 'Zerocross', 'Canny', 'Ruídos', 'Watershed', 'Histograma', 'Contagem Simples'};
            app.FiltrosDropDown.ValueChangedFcn = createCallbackFcn(app, @FiltrosDropDownValueChanged, true);
            app.FiltrosDropDown.FontSize = 14;
            app.FiltrosDropDown.FontWeight = 'bold';
            app.FiltrosDropDown.FontColor = [0.0118 0.0157 0.0196];
            app.FiltrosDropDown.BackgroundColor = [0.2392 0.7686 0.6627];
            app.FiltrosDropDown.Position = [737 577 176 31];
            app.FiltrosDropDown.Value = 'Escala de Cinza';

            % Create SelecioneumaOpoButtonGroup
            app.SelecioneumaOpoButtonGroup = uibuttongroup(app.UIFigure);
            app.SelecioneumaOpoButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @SelecioneumaOpoButtonGroupSelectionChanged, true);
            app.SelecioneumaOpoButtonGroup.ForegroundColor = [0.0118 0.0157 0.0196];
            app.SelecioneumaOpoButtonGroup.TitlePosition = 'centertop';
            app.SelecioneumaOpoButtonGroup.Title = 'Selecione uma Opção';
            app.SelecioneumaOpoButtonGroup.Visible = 'off';
            app.SelecioneumaOpoButtonGroup.FontWeight = 'bold';
            app.SelecioneumaOpoButtonGroup.FontSize = 14;
            app.SelecioneumaOpoButtonGroup.Position = [688 284 258 138];

            % Create Opt1Button
            app.Opt1Button = uiradiobutton(app.SelecioneumaOpoButtonGroup);
            app.Opt1Button.Text = 'Opt1';
            app.Opt1Button.FontSize = 14;
            app.Opt1Button.FontWeight = 'bold';
            app.Opt1Button.FontColor = [0.0118 0.0157 0.0196];
            app.Opt1Button.Position = [13 91 166 22];
            app.Opt1Button.Value = true;

            % Create Opt2Button
            app.Opt2Button = uiradiobutton(app.SelecioneumaOpoButtonGroup);
            app.Opt2Button.Text = 'Opt2';
            app.Opt2Button.FontSize = 14;
            app.Opt2Button.FontWeight = 'bold';
            app.Opt2Button.FontColor = [0.0118 0.0157 0.0196];
            app.Opt2Button.Position = [11 70 166 22];

            % Create Opt3Button
            app.Opt3Button = uiradiobutton(app.SelecioneumaOpoButtonGroup);
            app.Opt3Button.Text = 'Opt3';
            app.Opt3Button.FontSize = 14;
            app.Opt3Button.FontWeight = 'bold';
            app.Opt3Button.FontColor = [0.0118 0.0157 0.0196];
            app.Opt3Button.Position = [11 48 166 22];

            % Create Opt4Button
            app.Opt4Button = uiradiobutton(app.SelecioneumaOpoButtonGroup);
            app.Opt4Button.Text = 'Opt4';
            app.Opt4Button.FontSize = 14;
            app.Opt4Button.FontWeight = 'bold';
            app.Opt4Button.FontColor = [0.0118 0.0157 0.0196];
            app.Opt4Button.Position = [12 27 230 22];

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.UIFigure);
            app.EditFieldLabel.FontSize = 14;
            app.EditFieldLabel.FontWeight = 'bold';
            app.EditFieldLabel.FontColor = [0.0118 0.0157 0.0196];
            app.EditFieldLabel.Visible = 'off';
            app.EditFieldLabel.Position = [686 515 117 22];
            app.EditFieldLabel.Text = 'Edit Field';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'numeric');
            app.EditField.ValueChangedFcn = createCallbackFcn(app, @EditFieldValueChanged, true);
            app.EditField.FontColor = [0.0118 0.0157 0.0196];
            app.EditField.Visible = 'off';
            app.EditField.Position = [817 515 96 22];

            % Create AplicarFiltroButton
            app.AplicarFiltroButton = uibutton(app.UIFigure, 'push');
            app.AplicarFiltroButton.ButtonPushedFcn = createCallbackFcn(app, @AplicarFiltroButtonPushed, true);
            app.AplicarFiltroButton.BackgroundColor = [0.102 0.7373 0.6118];
            app.AplicarFiltroButton.FontSize = 14;
            app.AplicarFiltroButton.FontWeight = 'bold';
            app.AplicarFiltroButton.FontColor = [0.0118 0.0157 0.0196];
            app.AplicarFiltroButton.Position = [740 77 160 47];
            app.AplicarFiltroButton.Text = 'Aplicar Filtro';

            % Create EditField2Label
            app.EditField2Label = uilabel(app.UIFigure);
            app.EditField2Label.FontSize = 14;
            app.EditField2Label.FontWeight = 'bold';
            app.EditField2Label.FontColor = [0.0118 0.0157 0.0196];
            app.EditField2Label.Visible = 'off';
            app.EditField2Label.Position = [687 461 147 22];
            app.EditField2Label.Text = 'Edit Field2';

            % Create EditField2
            app.EditField2 = uieditfield(app.UIFigure, 'numeric');
            app.EditField2.FontColor = [0.0118 0.0157 0.0196];
            app.EditField2.Visible = 'off';
            app.EditField2.Position = [817 461 96 22];

            % Create ImagemOriginalLabel
            app.ImagemOriginalLabel = uilabel(app.UIFigure);
            app.ImagemOriginalLabel.HorizontalAlignment = 'center';
            app.ImagemOriginalLabel.FontName = 'Times New Roman';
            app.ImagemOriginalLabel.FontSize = 14;
            app.ImagemOriginalLabel.FontWeight = 'bold';
            app.ImagemOriginalLabel.FontColor = [0.0118 0.0157 0.0196];
            app.ImagemOriginalLabel.Position = [154 697 243 22];
            app.ImagemOriginalLabel.Text = 'Imagem Original';

            % Create ImagemcomFiltroLabel
            app.ImagemcomFiltroLabel = uilabel(app.UIFigure);
            app.ImagemcomFiltroLabel.HorizontalAlignment = 'center';
            app.ImagemcomFiltroLabel.FontName = 'Times New Roman';
            app.ImagemcomFiltroLabel.FontSize = 14;
            app.ImagemcomFiltroLabel.FontWeight = 'bold';
            app.ImagemcomFiltroLabel.FontColor = [0.0118 0.0157 0.0196];
            app.ImagemcomFiltroLabel.Position = [182 342 243 22];
            app.ImagemcomFiltroLabel.Text = 'Imagem com Filtro';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Trabalho_vi

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
